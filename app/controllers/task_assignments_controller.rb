class TaskAssignmentsController < ApplicationController
  before_action :find_assigned_task, except: %i[index new create]


  def index 
    @assigned_tasks = TaskAssignment.all
    render json: @assigned_tasks, status: :ok
  end

  def new
    @assigned_task = TaskAssignment.new
  end

  def create
    @assigned_task = TaskAssignment.new(set_params)
    if @assigned_task.save
      render json: @assigned_task
    else
      render json: {errors: @assigned_task.errors}, status: :unprocessabel_entity
    end
  end

  def show
    render json: @assigned_task
  end

  def edit
  end
  
  def update
    if @assigned_task.update(set_params)
      render json: @assigned_task
    else
      render json: {errors: @assigned_task.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @assigned_task.destroy
  end

  private
  def find_assigned_task
    @assigned_task = TaskAssignment.find(params[:id])
  end

  def set_params
    params.permit(:user_id, :task_id)
  end

end

