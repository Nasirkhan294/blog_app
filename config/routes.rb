Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show create new destroy]
  end

  get 'users/:user_id/posts/:post_id/comments/new', to: 'comments#new'
  post 'users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'comments'
  delete 'users/:user_id/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'destroy_user_comment'
  post 'users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'likes'
end
