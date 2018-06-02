Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  # SPAの開始ポイント
  get '/' => 'home#index'

  # API
  namespace :api, defaults: { format: :json } do
    resources :sessions, only: %i[create]
    resources :events, only: %i[index]
    resources :songs, only: %i[index show] do
      member do
        get 'histories'
      end
    end
  end
end
