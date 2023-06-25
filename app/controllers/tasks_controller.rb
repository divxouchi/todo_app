class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :basic_auth

  # GET /tasks or /tasks.json
  def index
    @completed_tasks = Task.where(completed: 1)
    @incomplete_tasks = Task.where(completed: 0 )
    @tasks_by_date = Task.where(completed: 0).group_by { |task| task.due_date }
  end
  

  # GET /tasks/1 or /tasks/1.json
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

 

  # POST /tasks or /tasks.json
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: 'Task was successfully created.'
    else
      @completed_tasks = Task.where(completed: 1)
      @incomplete_tasks = Task.where(completed: 0)
      @tasks_by_date = Task.where(completed: 0).group_by { |task| task.due_date }
      render :index
    end
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_url, notice: "Task was successfully updated."
    else
      render :edit
    end
  end
  
 # DELETE /tasks/1 or /tasks/1.json
 def destroy
  @task.destroy
  redirect_to tasks_url, notice: 'Task was successfully destroyed.'
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:title, :completed, :due_date)
    end

    def basic_auth
      authenticate_or_request_with_http_basic do |username, password|
        username == 'mouchi' && password == '123456'
      end
    end
end

