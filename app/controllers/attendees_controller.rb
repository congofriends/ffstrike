class AttendeesController < ApplicationController
  before_filter :load_event_and_movement, :only => [:create]

  def create
    @attendee = @event.attendees.build(attendee_params)
    if @attendee.save
      AttendeeMailer.signup_message(@movement, @event, @attendee).deliver
      redirect_to event_path(@event), notice: "You signed up for the event"
    else
      redirect_to movement_path(@movement, anchor: "events"),  notice: "Email is required"
    end
  end

  private
  def attendee_params
    params.require(:attendee).permit(:name, :email, :phone_number)
  end

  def load_event_and_movement 
    @event = Event.find params[:event_id]
    @movement = @event.movement
  end
end
