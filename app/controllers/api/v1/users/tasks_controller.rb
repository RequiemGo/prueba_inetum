class Api::V1::Users::TasksController < ApplicationController
  before_action :set_user

  def index
    tasks = @user.tasks.page(params[:page]).per(20)
    render json: tasks, meta: pagination_meta(tasks)
  end

  def create
    task = @user.tasks.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :not_found
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
