class AssignmentsController < ApplicationController
  before_filter :load_task_and_event, :only => [:assign]   

  def assign
    if session[:current_attendee_id]
      @task.assign!(session[:current_attendee_id])
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
