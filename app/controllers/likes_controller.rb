class LikesController < ApplicationController
  def create
    like = Like.new
    like.post = Post.find(params[:post_id])
    like.author = current_user

    if like.save
      flash[:success] = 'Like saved successfully'
    else
      flash.now[:error] = 'Error: Like could not be saved'
    end

    redirect_to '/'
  end
end
