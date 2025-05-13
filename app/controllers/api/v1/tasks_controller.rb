class Api::V1::TasksController < ApplicationController
  def index
    tasks = current_user.tasks.page(params[:page]).per(20)
    render json: tasks, meta: pagination_meta(tasks)
  end
end
