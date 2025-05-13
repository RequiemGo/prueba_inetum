class ApplicationController < ActionController::API
  include ExceptionHandler

  before_action :authenticate_request!

  attr_reader :current_user

  private

  def authenticate_request!
    token = request.headers["Authorization"]&.split&.last
    raise ExceptionHandler::InvalidTokenError, "Token is missing" if token.blank?

    begin
      payload = JsonWebToken.decode(token)
      @current_user = User.find(payload[:user_id])
    rescue JWT::ExpiredSignature
      raise ExceptionHandler::ExpiredTokenError, "Token has expired"
    rescue ActiveRecord::RecordNotFound
      raise ExceptionHandler::InvalidTokenError, "User not found"
    end
  end
  def pagination_meta(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end
end
