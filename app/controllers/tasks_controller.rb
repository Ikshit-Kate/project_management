class TasksController < ApplicationController
  before_action :find_task, except: %i[index new create]


  def index
    @tasks = Task.all
    # byebug
    # render json: {data: @tasks}, status: :ok
    render json: 
       {data: @tasks.each do |task| TaskSerializer.new(task)}
    end    
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(set_params)
    if @task.save
      render json: @task, status: :ok
    else
      render json: {errors:@task.errors}, status: :unprocessable_entity
    end
  end

  def show
    render json: {data: TaskSerializer.new(@task)}, status: :ok
  end

  def edit
  end

  def update
    if @task.update(set_params)
      render json: @task, status: :ok
    else
      render json: {error: "cannot update task's details"}, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
  end

  private
  def set_params
    params.permit(:title,:description, :due_date, :priority, :status)
  end

  def find_task
    @task = Task.find(params[:id])
  end

end
