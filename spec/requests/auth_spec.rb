require 'rails_helper'

RSpec.describe 'Authentication', type: :request do
  let!(:user)        { create(:user, password: 'password') }
  let(:token)        { JsonWebToken.encode(user_id: user.id) }
  let(:auth_headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'POST /api/v1/login' do
    it 'returns token with valid credentials' do
      post '/api/v1/login', params: { email: user.email, password: 'password' }

      expect(response).to have_http_status(:created)
      expect(json['token']).to be_present
    end

    it 'rejects bad password' do
      post '/api/v1/login', params: { email: user.email, password: 'wrong' }

      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe 'GET /api/v1/tasks with token' do
    before { create_list(:task, 2, user: user) }

    it 'works with valid token' do
      get '/api/v1/tasks', headers: auth_headers

      expect(response).to have_http_status(:ok)
    end

    it 'rejects missing token' do
      get '/api/v1/tasks'

      expect(response).to have_http_status(:unauthorized)
    end

    it 'rejects expired token' do
      expired = JsonWebToken.encode({ user_id: user.id }, 1.second.ago)
      get '/api/v1/tasks', headers: { 'Authorization' => "Bearer #{expired}" }

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
