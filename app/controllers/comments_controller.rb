class CommentsController < ApplicationController
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

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
