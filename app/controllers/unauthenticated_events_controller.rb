class UnauthenticatedEventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @movement = Movement.find_by_param params[:movement_id]
    @user = User.new user_params
    @event = Event.new event_params
    if @user.save
      sign_in(:user, @user)
      @event = @movement.events.build(event_params)
      @event.assign_host_and_approve @user
      TaskPopulator.assign_tasks @event
      if @event.save
        redirect_to event_path(@event)
      else
        redirect_to new_movement_event_path(@movement), notice: t('event.failure')
      end
    else
      flash[:notice] = t('user.invalid_credentials')
      render 'new'
    end
  end

  private

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :name, :address, :address2, :location_details, :city, :zip, :state, :start_time, :end_time, :host_id, :notes)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
