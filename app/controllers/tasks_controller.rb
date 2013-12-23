class TasksController < ApplicationController 
  before_action :load_movement
  before_action :load_task, :only => [:destroy, :edit, :show, :update]

  def index
    @tasks = @movement.tasks
  end

  def new
    @task = @movement.tasks.build
  end

  def create
    @task = @movement.tasks.build(task_params)
    if @task.save
      binding.pry
      flash[:notice] = "Task '#{@task.description}' is created"
      redirect_to movement_tasks_path
    else
      flash[:notice] = 
        if @task.errors.messages.has_key?(:rally_error_warning)
          @task.errors.full_messages.last 
        else 
           @task.errors.full_messages.flatten.join
        end
      redirect_to(:back)
    end
  end

  def destroy
    @task.destroy
    redirect_to  movement_tasks_path, notice: "Task is deleted"
  end

  def edit; end

  def update
    @task.update_attributes(task_params)
    redirect_to  movement_tasks_path, notice: "Task #{@task.id} id has been updated"
  end

  private
  def task_params
    params.require(:task).permit(:description, :small_rally, :medium_rally, :big_rally)
  end

  def load_movement
    @movement = Movement.find(params[:movement_id])
  end

  def load_task
    @task = Task.find(params[:id])
  end
end
