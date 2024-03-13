class DownloadChannel < ApplicationCable::Channel
  def subscribed
    @channel_name = SecureRandom.hex(16)
    stream_from @channel_name
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def download_orders(data)
    user_id = JSON.parse(data['args'])['user_id']
    user = User.find_by(id: user_id)

    unless user
      broadcast_message("User not found!")
      return
    end

    orders = user.orders
    if orders.empty?
      broadcast_message("No orders found!")
      return
    else
      broadcast_message("Processing download for user #{user_id}...")
    end

    sleep(3)

    orders_data = orders.map do |order|
      {
        order_id: order.id,
        product_name: order.product.name,
        product_code: order.product.code,
        ordered_date: order.created_at
      }
    end

    csv_data = CsvUtils.json_to_csv(orders_data)
    file_name = "orders_#{user_id}_#{Time.now.to_i}.csv"
    File.open(Rails.root.join('public', 'data', file_name), 'w') { |file| file.write(csv_data) }
    file_url = ENV['HOST'] + Rails.application.routes.url_helpers.file_path(file_name)
    broadcast_message(file: file_url, message: "Download ready!")
  end

  private

  def broadcast_message(message)
    ActionCable.server.broadcast(@channel_name, message)
  end
end
