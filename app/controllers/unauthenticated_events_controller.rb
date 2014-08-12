class UnauthenticatedEventsController < ApplicationController
  before_filter :load_movement

  def new
    redirect_unauthorized_user
    @event = Event.new
  end

  def create
    @user = User.new user_params
    @event = Event.new event_params
    if @user.save
      sign_in(:user, @user)
      @event = @movement.events.build(event_params)
      @event.assign_host_and_approve @user
      if @event.save
        clear_fields_on_tbd
        UserMailer.event_creation_message(@user.id, @event.id) if current_user
        redirect_to explanation_path(@event), notice: t('event.created') and return
      else
        redirect_to new_movement_event_path(@movement), notice: t('event.failure')
      end
    else
      flash[:notice] = t('user.invalid_credentials')
      render 'new'
    end
  end


  private

  def load_movement
    @movement = Movement.find_by_param params[:movement_id]
    redirect_to root_path unless @movement
  end

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :name, :description, :address, :address2, :location_details, :city, :zip, :state, :country, :start_time, :end_time, :host_id, :notes, :image, :flyer, :forum_option, :approved)
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email, :phone, :password, :password_confirmation)
  end

  def redirect_unauthorized_user
    redirect_to root_path, notice: t('event.already_signed_in') if current_user
  end

  def clear_fields_on_tbd
    clear_time_fields = {start_time: "", end_time: ""}
    @event.update(clear_time_fields) if params[:event][:time_tbd]
  end
end
