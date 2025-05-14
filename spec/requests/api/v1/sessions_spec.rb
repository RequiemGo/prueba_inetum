require 'rails_helper'

RSpec.describe 'Api::V1::Sessions', type: :request do
  let!(:user) { create(:user, password: 'password') }

  describe 'POST /api/v1/login' do
    context 'with valid credentials' do
      it 'returns 201 and a JWT token' do
        post '/api/v1/login', params: { email: user.email, password: 'password' }

        expect(response).to have_http_status(:created)
        expect(json['token']).to be_present
      end
    end

    context 'with invalid credentials' do
      it 'returns 401' do
        post '/api/v1/login', params: { email: user.email, password: 'wrong' }

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe 'DELETE /api/v1/logout' do
    let(:token)   { JsonWebToken.encode(user_id: user.id) }
    let(:headers) { { 'Authorization' => "Bearer #{token}" } }

    context 'with valid token' do
      it 'returns 204 No Content' do
        delete '/api/v1/logout', headers: headers

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'without token' do
      it 'returns 401' do
        delete '/api/v1/logout'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
