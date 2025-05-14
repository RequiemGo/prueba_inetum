module GraphQLHelper
  def gql(query, variables: {}, headers: {})
    payload = { query:, variables: variables }

    post '/graphql',
         params:  payload.to_json,
         headers: headers.merge('Content-Type' => 'application/json')

    JSON.parse(response.body, symbolize_names: true)
  end
end


RSpec.configure { |c| c.include GraphQLHelper, type: :request }
