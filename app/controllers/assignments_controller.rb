class AssignmentsController < ApplicationController
  before_filter :load_task_and_event, :only => [:assign]   

  def assign
    unless @task.assigned_attendees.include?(Attendee.find(session[:current_attendee_id])).nil?
      flash[:notice] = t('assignment.already_taken')
    end

    unless session[:current_attendee_id].nil?
      @task.assign!(session[:current_attendee_id])
      flash[:notice] = t('assignment.signed_up') 
    else
      flash[:notice] = t('assignment.for_attendees_only') 
      format.js
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
