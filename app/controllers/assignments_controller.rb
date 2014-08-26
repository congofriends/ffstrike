class AssignmentsController < ApplicationController
  
  def assign
    load_task_and_event

    if params["task"]["assign"] == '1'

      @task.assign! current_user
      flash[:notice] = t('assignment.signed_up')
    else
      @task.unassign! current_user
    end

    respond_to do |format|
      format.html { render nothing: true }
    end
  end

  private

  def load_task_and_event
    @event = Event.find_by_param params[:event_id]
    @task = Task.find(params[:id])
  end

end
