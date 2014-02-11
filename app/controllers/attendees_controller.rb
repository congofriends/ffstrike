class AttendeesController < ApplicationController
  before_filter :load_event_and_movement, :only => [:new, :create]

  def new
    @attendee = Attendee.new
  end

  def create
    @attendee = @event.attendees.build(attendee_params)
    if @attendee.save
      session[:current_attendee_id] = @attendee.id

      AttendeeMailer.signup_message(@movement, @event, @attendee).deliver
      redirect_to event_path(@event), notice: "Thanks for signing up!"
    else
      redirect_to new_event_attendee_path(@event),  notice: "Email is required"
    end
  end

  private
  def attendee_params
    params.require(:attendee).permit(:name, :email, :phone_number, :point_person)
  end

  def load_event_and_movement 
    @event = Event.find params[:event_id]
    @movement = @event.movement
  end
end
