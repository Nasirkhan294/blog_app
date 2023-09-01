Rails.application.routes.draw do
  devise_for :users

  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show create new destroy] do
      member do
        post 'like'
        delete 'unlike'
      end
      resources :comments, only: [:new, :create, :destroy]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
