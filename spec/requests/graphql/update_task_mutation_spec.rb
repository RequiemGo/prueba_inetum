require 'rails_helper'

RSpec.describe 'GraphQL updateTask mutation', type: :request do
  let!(:user)    { create(:user) }
  let!(:task)    { create(:task, status: :pending, user: user) }

  let(:token)    { JsonWebToken.encode(user_id: user.id) }
  let(:headers)  { { 'Authorization' => "Bearer #{token}" } }

  let(:mutation) do
    <<~GQL
      mutation($input: UpdateTaskInput!) {
        updateTask(input: $input) {
          id
          status
          title
        }
      }
    GQL
  end

  it 'updates the task status' do
    variables = {
      input: {
        id: task.id,
        status: 'done'
      }
    }

    result = gql(mutation, variables: variables, headers: headers)
    expect(result[:errors]).to be_nil

    data = result.dig(:data, :updateTask)
    expect(data[:status]).to eq 'done'
    expect(task.reload.status).to eq 'done'
  end
end
