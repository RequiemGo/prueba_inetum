require 'rails_helper'

RSpec.describe 'GraphQL users query', type: :request do
  let!(:user)    { create(:user_with_tasks, tasks_count: 2) }
  let(:token)    { JsonWebToken.encode(user_id: user.id) }
  let(:headers)  { { 'Authorization' => "Bearer #{token}" } }

  let(:query) do
    <<~GQL
      {
        users {
          id
          name
          tasks { id title }
        }
      }
    GQL
  end

  it 'returns every user with their tasks' do
    result = gql(query, headers: headers)
    expect(result[:errors]).to be_nil

    data = result[:data][:users]
    expect(data.size).to eq 1
    expect(data[0][:tasks].size).to eq 2
    expect(data[0][:name]).to eq user.name
  end
end
