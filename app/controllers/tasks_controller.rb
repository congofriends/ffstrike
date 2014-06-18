class TasksController < ApplicationController
  before_action :load_event
  before_action :load_task, :only => [:destroy, :edit, :show, :update]

  def create
    @task = @event.tasks.build(task_params)
    flash[:notice] =
      @task.save ? t('task.created') : @task.errors.full_messages.flatten.join('. ')
    respond_to do |format|
      format.html { redirect_to my_events_path(:name => { :id => @event.id }, anchor: "tasks") }
      # format.html {  render nothing: true }
      format.js
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to  movement_path(@event.movement, anchor: "tasks"), notice: t('task.deleted') }
      format.js
    end
  end

  def edit; end

  def update
    @task.update_attributes(task_params)
    respond_to do |format|
      format.html { redirect_to  movement_path(@event.movement, anchor: "tasks"), notice: t('task.updated')}
      format.json { head :ok  }
    end
  end

  private
  def task_params
    params.require(:task).permit(:description)
  end

  def load_event
    @event = Event.find_by_param params[:event_id]
  end

  def load_task
    @task = Task.find(params[:id])
  end
end
