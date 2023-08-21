Rails.application.routes.draw do
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: :user
  get '/users/:user_id/posts', to: 'posts#index', as: :user_posts
  get '/posts/:id', to: 'posts#show', as: :post
end
