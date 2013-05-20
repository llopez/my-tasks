class TasksController < ApplicationController
  def index
    @tasks = Task.all
    respond_to do |format|
      format.json do
        render json: @tasks
      end
      format.html
    end
  end
  
  def show
    @task = Task.find(params[:id])
    render json: @task
  end
  
  def create
    @task = Task.new(task_params)
    @task.save
    render json: @task.to_json(methods: :errors)
  end

  def update
    @task = Task.find(params[:id])
    @task.update_attributes(task_params)
    render json: @task.to_json(methods: :errors)
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    render :nothing => true
  end
  
private
  def task_params
    params.require(:task).permit(:title)
  end
end
