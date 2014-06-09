class UnauthenticatedEventsController < ApplicationController
  before_filter :load_event_types, only: [:show]
  before_filter :load_movement, except: [:new, :create, :index, :user_movements, :new_submovement]
  before_filter :load_movements, only: [:index, :search]
  before_filter :redirect_unauthorized_user, only: [:new]

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

  def load_movements
    @movements = Movement.all.published.where(parent_id: nil)
  end

  def load_movement
    @movement = Movement.find_by_param params[:id]
  end

  def load_event_types
    @event_types = EventType.names
  end

  def event_type
    load_event_types
  end

  private

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :name, :description, :address, :address2, :location_details, :city, :zip, :state, :start_time, :end_time, :host_id, :notes)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def redirect_unauthorized_user
    redirect_to root_path, notice: t('event.already_signed_in') if current_user
  end
end
