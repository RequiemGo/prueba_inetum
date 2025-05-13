class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate_request!, only: :create

  def create
    user = User.find_by(email: params[:email].to_s.downcase)

    unless user&.authenticate(params[:password])
      raise ExceptionHandler::AuthenticationError, "Invalid email or password"
    end

    token = JsonWebToken.encode(user_id: user.id)
    render json: { token:, exp: 24.hours.from_now.strftime("%F %T") }, status: :created
  end

  def destroy
    head :no_content
  end
end
