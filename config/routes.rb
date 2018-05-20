Rails.application.routes.draw do

  get '/' => 'home#index'

  # API
  namespace :api, defaults: { format: :json } do
    resources :events, only: %i[index]
    resources :songs, only: %i[index]
  end
end
