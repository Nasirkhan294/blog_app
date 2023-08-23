require 'rails_helper'
RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    it 'renders the posts index template and includes correct placeholder' do
      User.create(name: 'Nasir')
      get '/users/1/posts'
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a list of posts for a given user')
    end
  end
  describe 'GET /show' do
    it 'renders the post show template and includes correct placeholder' do
      Post.create(title: 'My Post')
      get '/users/1/posts/1'
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include('Here are details for a given post')
    end
  end
end