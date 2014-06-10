class AssignmentsController < ApplicationController

  def assign
    load_task_and_event

    if current_user && (@task.is_not_assigned_to? current_user)
      @task.assign! current_user
      flash[:notice] = t('assignment.signed_up')
    else
      flash[:notice] = t('assignment.for_attendees_only')
    end

    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.js
    end
  end

  private
  def load_task_and_event
    @event = Event.find_by_param params[:event_id]
    @task = Task.find(params[:id])
  end
end
