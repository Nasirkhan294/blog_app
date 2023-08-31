class CommentsController < ApplicationController
  authorize_resource

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    comment = Comment.new(comment_params)
    comment.post = Post.find(params[:post_id])
    comment.author = current_user

    if comment.save
      flash[:success] = 'Comment saved successfully'
      redirect_to '/'
    else
      flash.now[:error] = 'error: comment could not be saved'
      redirect_to new_comment
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    post.comments.destroy(params[:id])
    redirect_to "/users/#{params[:user_id]}/posts/#{post.id}"
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
