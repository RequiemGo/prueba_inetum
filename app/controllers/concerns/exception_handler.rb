module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end
  class InvalidTokenError    < StandardError; end
  class ExpiredTokenError    < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from AuthenticationError,          with: :unauthorized
    rescue_from InvalidTokenError,            with: :unauthorized
    rescue_from ExpiredTokenError,            with: :unauthorized
    rescue_from JWT::DecodeError,             with: :invalid_token
  end

  private

  def unauthorized(e)
    render json: { errors: e.message }, status: :unauthorized
  end

  def invalid_token(_e)
    render json: { errors: "Invalid or missing token" }, status: :unauthorized
  end

  def not_found(e)
    render json: { errors: e.message }, status: :not_found
  end
end
