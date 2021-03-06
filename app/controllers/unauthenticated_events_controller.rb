class UnauthenticatedEventsController < ApplicationController
  before_filter :load_movement

  def new
    redirect_unauthorized_user
    @event = Event.new
    event_type_name = params[:type] || EventType.first.name
    @event_type = EventType.find_by(name: event_type_name)
  end

  def create
    @user = User.new user_params
    @event = Event.new event_params
    if verify_recaptcha(model: @user) && @user.save
      sign_in(:user, @user)
      @event = @movement.events.build(event_params)
      @event.assign_host @user
      if @event.save
        clear_fields_on_tbd
        NewEventMailWorker.perform_async(@user.id, @event.id) if ENV["RAILS_ENV"] == "production" && current_user
        redirect_to my_events_path, notice: t('event.created') and return
      else
        redirect_to new_movement_event_path(@movement), alert: @event.errors.full_messages.flatten.join('. ')
      end
    else
      flash[:alert] = @user.errors.full_messages.flatten.join(' ')
      render 'new'
    end
  end

  private

  def load_movement
    @movement = Movement.find_by_param params[:movement_id]
    redirect_to root_path unless @movement
  end

  def event_params
    @event_type = EventType.find_by(name: params[:event][:event_type]) if params[:event][:event_type]
    params[:event][:event_type_id] = @event_type.id if @event_type
    params.require(:event).permit(:event_type_id, :name, :description, :address, :address2, :location_details, :city, :zip, :state, :country, :start_time, :end_time, :host_id, :notes, :image, :flyer, :forum_option, :approved)
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email, :phone, :password, :password_confirmation)
  end

  def redirect_unauthorized_user
    redirect_to root_path, alert: t('event.already_signed_in') if current_user
  end

  def clear_fields_on_tbd
    clear_time_fields = {start_time: "", end_time: ""}
    @event.update(clear_time_fields) if params[:event][:time_tbd]
  end
end
