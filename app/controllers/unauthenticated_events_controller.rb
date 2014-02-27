class UnauthenticatedEventsController < ApplicationController

  def new
    @event = Event.new      
  end

  def create
    @movement = Movement.find params[:movement_id]
    user = User.create user_params
    sign_in(:user, user)
    event = @movement.events.build(event_params)
    event.assign_host_and_approve user
    TaskPopulator.assign_tasks event
    redirect_to event_path(event)
  end

  private
  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :name, :address, :location_details, :city, :zip, :date, :time, :host_id, :notes)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
