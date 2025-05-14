module RequestHelper
  def json
    JSON.parse(response.body)
  end
end

RSpec.configure { |c| c.include RequestHelper, type: :request }
