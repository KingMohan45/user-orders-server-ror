Rails.application.configure do
  config.action_cable.allowed_request_origins = ['http://localhost:8000','http://localhost:3000']
  config.allow_same_origin_as_host = true
  config.disable_request_forgery_protection = false
end
module ActionCable
  module Server
    module Connections
      BEAT_INTERVAL = 300
    end
  end
end
