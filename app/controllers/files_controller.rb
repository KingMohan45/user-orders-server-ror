class FilesController < ApplicationController
  def download
    send_file Rails.root.join('public','data', "#{params[:filename]}.csv"), disposition: 'inline'
  end
end
