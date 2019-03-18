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
    resources :events, only: %i[index show create update]
    resources :histories, only: %i[index show create]
    resources :songs, only: %i[index show] do
      member do
        get 'users'
        get 'histories'
      end
      collection do
        get 'names'
      end
    end
    resources :artists, only: %i[show] do
      member do
        get 'histories'
      end
      collection do
        get 'names'
      end
    end
  end
end
