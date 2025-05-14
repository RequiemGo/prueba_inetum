require 'rails_helper'

RSpec.describe 'Api::V1::Tasks', type: :request do
  let!(:user)    { create(:user) }
  let!(:tasks)   { create_list(:task, 3, user: user) }
  let(:token)    { JsonWebToken.encode(user_id: user.id) }
  let(:headers)  { { 'Authorization' => "Bearer #{token}" } }

  describe 'GET /api/v1/tasks' do
    context 'with valid token' do
      it 'returns http success and the list of tasks' do
        get '/api/v1/tasks', headers: headers

        expect(response).to have_http_status(:ok)
        expect(json.size).to eq 3
        expect(json.map { |t| t['id'] }.sort).to match_array(tasks.map(&:id))
      end
    end

    context 'without token' do
      it 'returns unauthorized' do
        get '/api/v1/tasks'

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
