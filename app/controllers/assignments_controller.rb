class AssignmentsController < ApplicationController
  before_filter :load_task_and_event, :only => [:assign]   

  def assign
    unless @task.assigned_attendees.include?(Attendee.find(session[:current_attendee_id])).nil?
      flash[:notice] = "You've already taken this task!"
    end

    unless session[:current_attendee_id].nil?
      @task.assign!(session[:current_attendee_id])
      flash[:notice] = "Thanks for signing up!" 
    else
      flash[:notice] =  "Tasks are for attendees only"
      format.js
    end

    respond_to do |format|
      format.html { redirect_to event_path(@event) }
      format.js
    end
  end

  private
  def load_task_and_event
    @event = Event.find(params[:event_id])
    @task = Task.find(params[:id])
  end
end
