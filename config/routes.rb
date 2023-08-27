Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index new create show]
  end

  resources :posts do
    resources :comments, only: %i[new create]
    resources :likes, only: [:create]
  end
  root 'users#index'
end
