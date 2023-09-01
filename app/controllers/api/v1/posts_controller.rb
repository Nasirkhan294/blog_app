class Api::V1::PostsController < Api::ApiController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts

    render json: @posts, include: %w[author comments]
  end
end
