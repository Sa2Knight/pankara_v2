Rails.application.routes.draw do
  # SPAの開始ポイント
  get '/' => 'home#index'

  # API
  namespace :api, defaults: { format: :json } do
    post :user_token, to: 'user_token#create'
    resources :sessions, only: %i[create]
    resources :users, only: %i[show] do
      collection do
        get :myself
      end
    end
    resources :events, only: %i[index show]
    resources :histories, only: %i[index show]
    resources :songs, only: %i[index show] do
      member do
        get 'users'
        get 'histories'
      end
    end
    resources :artists, only: %i[show] do
      member do
        get 'histories'
      end
    end
  end
end
