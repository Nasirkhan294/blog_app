require 'rails_helper'
RSpec.describe 'Users', type: :request do
  describe 'GET /index' do
    it 'renders the users index template and includes correct placeholder' do
      get '/users'
      expect(response).to be_successful
      expect(response).to render_template(:index)
      expect(response.body).to include('List of Users')
    end
  end
  describe 'GET /show' do
    it 'renders the users show template and includes correct placeholder' do
      User.create(name: 'Nasir')
      get '/users/1'
      expect(response).to be_successful
      expect(response).to render_template(:show)
      expect(response.body).to include('Details about the user!')
    end
  end
end
