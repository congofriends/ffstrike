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
      UserMailer.notify_host_of_event_size(@event) if @event.threshold_size? 
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
    @event = Event.find_by_param params[:event_id]
    @movement = @event.movement
  end
end
