class CommentsController < ApplicationController
  authorize_resource

  before_action :find_user_post

  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new(comment_params)
    comment.post = @post
    comment.author = current_user

    if comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to user_post_path(user_id: @user.id, id: @post.id)
    else
      flash.now[:error] = 'error: comment could not be saved'
      redirect_to new_user_post_comment_path(user_id: @user.id, post_id: @post.id)
    end
  end

  def destroy
    @post.comments.destroy(params[:id])
    redirect_to user_post_path(user_id: @user.id, id: @post.id)
  end

  private

  def find_user_post
    @post = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
