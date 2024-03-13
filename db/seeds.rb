# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with  ).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a user
require 'csv'
def seed_independent_models
  independent_models_seed_data_mapping = {
    User => {
      'USERNAME' => :username,
      'EMAIL' => :email,
      'PHONE' => :phone
    },
    Product => {
      'CODE' => :code,
      'NAME' => :name,
      'CATEGORY' => :category
    },
  }
  begin
    ActiveRecord::Base.transaction do
      independent_models_seed_data_mapping.each do |model, headers_mapping|
        puts "Seeding #{model}..."
        filename = Rails.root.join('db','seed_data', "#{model.to_s.downcase}.csv")
        CsvUtils.create_records_from_csv(filename, model, headers_mapping)
      end
    end
  rescue StandardError => e
    raise ActiveRecord::Rollback
  end
end

def seed_orders
  begin
    ActiveRecord::Base.transaction do
      puts "Seeding orders..."
      filename = Rails.root.join('db','seed_data', "order.csv")
      rows = CsvUtils.read_csv(filename)
      rows.each do |row|
        begin
          puts "Processing row: #{row}"
          order = Order.new
          order.user = User.find_by(email: row['USER_EMAIL'])
          order.product = Product.find_by(code: row['PRODUCT_CODE'])
          order.created_at = row['ORDER_DATE']
          order.save!
        rescue ActiveRecord::RecordNotUnique => e
          puts "Record already exists! Skipping..."
        rescue StandardError => e
          puts "Error creating record: #{e.message}"
        end
      end
      puts "Created #{rows.length} records from #{filename} in the Order model."
    end
  end
end

seed_independent_models
seed_orders