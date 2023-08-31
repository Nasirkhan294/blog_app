class PostsController < ApplicationController
  authorize_resource

  def index
    page = params[:page] || 1
    per_page = 10

    user = User.find(params[:user_id])
    @posts = user.posts.includes(:author)
      .includes(:comments)
      .order(created_at: :asc)
      .offset((page.to_i - 1) * per_page)
      .limit(per_page)

    @total_pages = (Post.count.to_f / per_page).ceil
    @author = @posts.first.author unless @posts.first.nil?
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
    @like = Like.new
  end

  def create
    post = Post.new(post_params)
    post.author = current_user
    post.comments_counter = 0
    post.likes_counter = 0

    if post.save
      flash[:success] = 'post saved successfully'
      redirect_to '/'
    else
      flash.now[:error] = 'error: question could not be saved'
      redirect_to new_user_post_path
    end
  end

  def new
    @post = Post.new
    @current_user = current_user
  end

  def destroy
    @current_user = current_user
    @current_user.posts.destroy(params[:id])
    redirect_to "/users/#{params[:user_id]}/posts"
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
