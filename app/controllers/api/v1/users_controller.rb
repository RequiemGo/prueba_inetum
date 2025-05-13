class Api::V1::UsersController < ApplicationController
  def index
    users = User.page(params[:page]).per(20)
    render json: users, meta: pagination_meta(users)
  end

  def show
    user = User.find(params[:id])
    render json: user
  end
end
