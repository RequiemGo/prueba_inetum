require 'rails_helper'

RSpec.describe 'GraphQL tasks query', type: :request do
  let!(:user)   { create(:user) }
  let!(:pending) { create_list(:task, 2, status: :pending) }
  let!(:done)    { create(:task, status: :done) }
  let(:token)  { JsonWebToken.encode(user_id: user.id) }
  let(:headers) { { 'Authorization' => "Bearer #{token}" } }
  let(:base_query) { "tasks { id status }" }

  it 'returns all tasks when no status arg' do
  result = gql("{ #{base_query} }", headers: headers)
  expect(result[:errors]).to be_nil
  data = result[:data][:tasks]
  expect(data.size).to eq 3
end

it 'returns only tasks with the requested status' do
  result = gql("query($s:String){ tasks(status:$s){ id status } }",
               variables: { s: 'pending' },
               headers: headers)
  expect(result[:errors]).to be_nil
  data = result[:data][:tasks]
  expect(data.size).to eq 2
  expect(data.map { |t| t[:status] }.uniq).to eq [ 'pending' ]
end
end
