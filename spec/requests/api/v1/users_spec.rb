require 'rails_helper'

RSpec.describe 'Api::V1::Users', type: :request do
  let!(:user)   { create(:user) }
  let(:token)   { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'GET /api/v1/users' do
    it 'returns http success and list of users' do
      get '/api/v1/users', headers: headers

      expect(response).to have_http_status(:ok)
      expect(json.first['id']).to eq user.id
    end
  end

  describe 'GET /api/v1/users/:id' do
    it 'returns http success and the user data' do
      get "/api/v1/users/#{user.id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(json['id']).to eq user.id
    end
  end
end
