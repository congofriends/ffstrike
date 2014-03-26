class AttendeesController < ApplicationController
  before_filter :load_event_and_movement, :only => [:new, :create]
  before_filter :load_attendee, only: [:update]

  def new
    @attendee = Attendee.new
  end

  def create
    @attendee = @event.attendees.build(attendee_params)
    if @attendee.save
      session[:current_attendee_id] = @attendee.id
      AttendeeMailer.signup_message(@movement, @event, @attendee).deliver
      UserMailer.notify_host_of_event_size(@event) if @event.threshold_size? 
      redirect_to event_path(@event), notice: t('attendee.created')
    else
      redirect_to new_event_attendee_path(@event), notice: t('attendee.email_is_required')
    end
  end

  def update
    @attendee.update(attendee_params)
    respond_to do |format|
      format.html { redirect_to movement_path(@attendee.event.movement, anchor: "attendees"), notice: t('attendee.updated') }
      format.json { head :ok  }
    end
  end

  private
  def attendee_params
    params.require(:attendee).permit(:name, :notes, :email, :phone_number, :point_person)
  end

  def load_event_and_movement 
    @event = Event.find_by_param params[:event_id]
    @movement = @event.movement
  end

  def load_attendee
    @attendee = Attendee.find(params[:id])
  end
end
