require 'rails_helper'

RSpec.describe 'GraphQL createTask mutation', type: :request do
  let!(:user)  { create(:user) }
  let(:token)  { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }

  let(:mutation) do
    <<~GQL
      mutation($input: CreateTaskInput!) {
        createTask(input: $input) {
          id
          title
          status
          user { id }
        }
      }
    GQL
  end

  it 'creates a task and returns its data' do
    variables = {
      input: {
        userId: user.id,
        title: 'GraphQL intro',
        description: 'Learn GraphQL mutations',
        status: 'pending',
        dueDate: 1.week.from_now.to_date.iso8601
      }
    }

    result = gql(mutation, variables:, headers:)
    data   = result.dig(:data, :createTask)

    expect(result[:errors]).to be_nil
    expect(data[:title]).to eq 'GraphQL intro'
    expect(data[:status]).to eq 'pending'
    expect(data[:user][:id].to_i).to eq user.id
    expect(user.tasks.reload.count).to eq 1
  end
end
