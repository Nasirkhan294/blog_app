require 'rails_helper'
RSpec.describe 'Users', type: :request do
  before(:all) do
    @user = User.create(name: 'Tom', photo: 'https://placehold.co/200x133', bio: 'Teacher from Mexico.',
                        posts_counter: 0)
  end
  describe 'GET /index' do
    it 'renders the users index template and includes correct placeholder' do
      get '/users'
      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end
  describe 'GET /show' do
    it 'renders the users show template and includes correct placeholder' do
      User.create(name: 'Nasir')
      get '/users/#{@user.id}'
      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
