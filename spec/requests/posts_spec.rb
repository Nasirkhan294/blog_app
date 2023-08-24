require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  before(:all) do
    @user = User.create(name: 'Tom', photo: 'https://placehold.co/200x133', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    @post = Post.create(author: @user, title: 'Hello', text: 'This is my first post', comments_counter: 0,
                        likes_counter: 0)
  end
  describe 'GET /index' do
    it 'renders the posts index template and includes correct placeholder' do
      User.create(name: 'Nasir')
      get '/users/#{@user.id}/posts'
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
  describe 'GET /show' do
    it 'renders the post show template and includes correct placeholder' do
      Post.create(title: 'My Post')
      get '/users/#{@user.id}/posts/#{@post.id}'
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include('Here are details for a given post')
    end
  end
end
