class TasksController < ApplicationController 
  before_action :load_movement
  before_action :load_task, :only => [:destroy, :edit, :show, :update]

  def create
    @task = @movement.tasks.build(task_params)
    flash[:notice] = 
      @task.save ? "New task is created" : @task.errors.full_messages.flatten.join('. ')
      redirect_to movement_path(@movement)
  end

  def destroy
    @task.destroy
    redirect_to  movement_path(@movement), notice: "Task is deleted"
  end

  def edit; end

  def update
    @task.update_attributes(task_params)
    redirect_to  movement_path(@movement), notice: "Task #{@task.id} id has been updated"
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
