class EventsController < ApplicationController
  before_filter :load_event, :only => [:approve, :show, :update, :destroy, :edit, :export_attendees, :sponsor]
  before_filter :load_movement, :only => [:new, :create, :edit, :update, :index]
  before_filter :redirect_unauthorized_user, :only => [:edit]
  before_filter :load_event_types, :only => [:edit]

  include ZipHelper

  def new
    redirect_to new_user_session_path and return unless current_user
    @event = Event.new
  end

  def index
    redirect_to root_path and return unless @movement
    @events = Event.near_zip(params[:zip], 200)
    respond_to do |format|
      unless @events.empty?
        @events = (@events.public_events << @events.where(start_time: nil)).flatten
        load_map_vars
        @events = Kaminari.paginate_array(@events).page(params[:page]).per(5)
        @coordinates = Geocoder.coordinates(params[:zip])
        format.html {redirect_to movement_events_path}
        format.js
      else
        @events = (Event.public_events << Event.where(start_time: nil)).flatten
        load_map_vars
        @events = Kaminari.paginate_array(@events).page(params[:page]).per(5)
        flash[:notice] = t('event.not_found') if params[:zip].present?
        format.html { render action: "index"}
        format.js{ render "errors"}
      end
    end
  end

  def approve
    @event.update(approved: params[:event][:approved])
    respond_to do |format|
      format.html { render nothing: true }
    end
  end

  def sponsor
    @event.update(sponsored: params[:event][:sponsored])
    respond_to do |format|
      format.html { render nothing: true }
    end
  end

  def assign_volunteer
    @event = Event.find params[:event_id]
    @attendee = User.find params[:attendee_id]
    @attendance = @attendee.attendances.find_by(event_id: @event.id)
    @attendance.update(point_person: params[:event][:assigned])
    respond_to do |format|
      format.html { render nothing: true }
    end
  end

  def unattend
    @event = Event.find params[:event_id]
    @attendee = User.find params[:attendee_id]
    attendance = @attendee.attendances.find_by(event_id: @event.id)
    attendance.destroy if attendance
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def show
    load_all_movements
    redirect_to root_path, notice: t('event.no_route') and return unless @event
    respond_to do |format|
      format.html do
        render 'show'
      end
    end
    rescue ActiveRecord::RecordNotSaved
      redirect_to root_path, notice: t('event.no_route')
  end

  def create
    @movement = Movement.find_by_name(params["event"]["movement"]) if params["event"]["movement"] && params["event"]["movement"] != ""
    @event = @movement.events.build(event_params)
    if @event.save
      clear_fields_on_tbd
      UserMailer.event_creation_message(current_user.id, @event.id) if ENV["RAILS_ENV"] == "qa"
      NewEventMailWorker.perform_async(current_user.id, @event.id) if ENV["RAILS_ENV"] == "production"
      @event.assign_host(current_user)
      redirect_to my_events_path, notice: t('event.created') and return
    else
      flash[:alert] = @event.errors.full_messages.flatten.join(' ')
      if @movement.users.include?(current_user)
       redirect_to my_groups_path and return
      end
      redirect_to movement_path(@movement) and return
    end
  end

  def my_events
    redirect_to root_path and return unless current_user
    @events = current_user.events_owned & current_user.current_events
    @event = (params[:name] && (Event.where(id: params[:name][:id]).count > 0)) ? (Event.find params[:name][:id]) : @events.first
    redirect_to root_path and return unless (@events.include?(@event)  && !@events.empty?) || current_user.super_admin?
    respond_to do |format|
      format.html {render action: 'my_events'}
      format.js
    end
  end

  def update
    set_initial_location
    if @event.update_attributes(event_params)
      check_for_address_update
      @event.update movement: Movement.find_by_name(params[:event][:movement])
      flash[:notice] = t('event.updated')
    end
    redirect_to request.referer
  end

  def destroy
    authenticate_user!
    UserMailer.delete_event_message(@event.id)

    @event.destroy
    respond_to do |format|
      format.html { redirect_to my_groups_path, notice: t('event.deleted') }
      format.js
    end
  end

  def search_by_keyword; end

  def edit; end

  def export_attendees
    send_data @event.to_csv, filename: "#{@event.name} attendee-list.csv"
  end

  private

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :address2, :name, :address, :location_details, :description, :city, :zip, :state, :country, :start_time, :image, :flyer, :end_time, :host_id, :notes, :forum_option, :approved)
  end

  def load_map_vars
    gon.events = @events.reject { |e| e.latitude.nil? || e.longitude.nil? }
    gon.event_types = EventType.all
    gon.event_images = []
    gon.times = []
    gon.addresses = []
    gon.location_details = []
    gon.event_ids = []
    gon.event_pks = []
    gon.locale = I18n.locale.to_s
    gon.events.each do |e|
      gon.event_pks << e.id
      gon.event_ids << e.to_param
      gon.addresses << e.location
      gon.location_details << e.location_details
      gon.times << e.formatted_time
      gon.event_images << ActionController::Base.helpers.asset_path(e.image.url)
    end
  end

  def load_event
    @event = Event.find_by_param params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('event.no_route')
  end

  def load_movement
    if params[:movement_id]
      @movement = Movement.find_by_param params[:movement_id]
    elsif @event
      @movement = @event.movement
    else
      @movement = Movement.first
    end
  end

  def load_all_movements
    @movements = Movement.all.published
  end

  def check_for_address_update
    @event.assign_coordinates unless @initial_location == @event.location
  end

  def set_initial_location
    @initial_location = @event.location
  end

  def load_event_types
    @event_types = EventType.all.map {|e| [e.id, e.name]}
  end

  def redirect_unauthorized_user
    unless @event.host?(current_user)
      redirect_to root_path, alert: t('event.not_yours')
    end
  end

  def clear_fields_on_tbd
    clear_time_fields = {start_time: "", end_time: ""}
    @event.update(clear_time_fields) if params[:event][:time_tbd]
  end
end
