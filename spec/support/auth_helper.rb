module AuthHelper
  def auth_headers(user)
    token = JsonWebToken.encode(user_id: user.id)
    { 'Authorization' => "Bearer #{token}" }
  end
end

RSpec.configure { |c| c.include AuthHelper, type: :request }
