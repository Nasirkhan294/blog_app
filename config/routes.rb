Rails.application.routes.draw do
  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show, create, new]
  end

  get 'users/:user_id/posts/:post_id/comments/new', to: 'comments#new'
  post 'users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'comments'
  post 'users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'likes'
end
