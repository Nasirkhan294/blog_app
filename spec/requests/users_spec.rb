require 'rails_helper'
RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders the users index template and includes correct placeholder' do
      get '/users'
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include('Here is a the list of all users')
    end
  end
  describe 'GET /show' do
    it 'renders the users show template and includes correct placeholder' do
      User.create(name: 'Nasir')
      get '/users/1'
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include('Here are details for a given user')
    end
  end
end
