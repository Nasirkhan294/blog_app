class PostsController < ActionController::Base
    def index
      @post = Post.all
    end
  
    def show
      @post = Post.find(params[:id])
    end
  end