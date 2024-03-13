Rails.application.routes.draw do
  mount ActionCable.server => '/ws/'
  resources :users, only: [:index, :show]

  # Serve files from the public directory
  get "files/:filename", to: "files#download", as: :file

  get "up" => "rails/health#show", as: :rails_health_check

end
