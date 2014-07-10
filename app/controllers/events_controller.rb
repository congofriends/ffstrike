class EventsController < ApplicationController
  before_filter :load_event, :only => [:approve, :show, :update, :destroy, :explanation, :edit, :export_attendees]
  before_filter :load_movement, :only => [:new, :create, :edit, :update, :index]
  before_filter :redirect_unauthorized_user, :only => [:edit]
  before_filter :load_event_types, :only => [:edit]

  include ZipHelper

  def new
    @event = Event.new
  end

  def index
    @events = Event.near_zip(params[:zip], 200)
    respond_to do |format|
      unless @events.empty?
        @coordinates = Geocoder.coordinates(params[:zip])
        load_map_vars
        format.html {redirect_to movement_events_path}
        format.js
      else
        @events = Event.where(approved: true)
        load_map_vars
        flash[:notice] = t('event.not_found') if params[:zip].present?
        format.html { render action: "index"}
        format.js{ render "errors"}
      end
    end
  end

  def approve
    @event.update(approved: !@event.approved)
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def assign_volunteer
    @event = Event.find params[:event_id]
    @attendee = User.find params[:attendee_id]
    @attendance = @attendee.attendances.find_by(event_id: @event.id)
    @attendance.update(point_person: !@attendance.point_person)
    respond_to do |format|
      format.html { render nothing: true }
      format.js
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

    respond_to do |format|
      format.html do
        render 'show'
      end
    end
  end

  def create
    @movement = Movement.find_by_name(params["event"]["movement"]) if params["event"]["movement"] && params["event"]["movement"] != ""
    @event = @movement.events.build(event_params)
    if @event.save
      @event.assign_host_and_approve(current_user)
      if @movement.users.include?(current_user)
        redirect_to explanation_path(@event), notice: t('event.created') and return
      end
      redirect_to explanation_path(@event), notice: t('event.created_by_attendee') and return
    else
      flash[:notice] = @event.errors.full_messages.flatten.join(' ')
      if @movement.users.include?(current_user)
       redirect_to my_groups_path and return
      end
      redirect_to movement_path(@movement) and return
    end
  end

  def my_events
    @events = current_user.events_owned
    @event = Event.find params[:name][:id] if params[:name] && (Event.where(id: params[:name][:id]).count > 0)
    respond_to do |format|
      format.html {render action: 'my_events'}
      format.js
    end
  end

  def search
    #FIXME: refactor this method here and in the movements_controller, currently it
    #is just clear duplication
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = Event.near_zip(@zip, 200)
  end

  def update
    if @event.update_attributes(event_params)
      flash[:notice] = t('event.updated')
    end

    redirect_to request.referer
  end

  def destroy
    authenticate_user!

    #todo: move to queue!
    @event.attendees.each do |attendee|
      UserMailer.delete_event_message(@event.id, attendee.email)
    end

    @event.destroy
    respond_to do |format|
      format.html { redirect_to my_groups_path, notice: t('event.deleted') }
      format.js
    end
  end

  def explanation; end

  def search_by_keyword; end

  def edit; end

  def export_attendees
    send_data @event.to_csv, filename: "Attendee List"
  end

  private

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :address2, :name, :address, :location_details, :description, :city, :zip, :state, :start_time, :image, :flyer, :end_time, :host_id, :notes, :forum_option, :approved)
  end

  def load_map_vars
    gon.events = @events.reject { |e| e.latitude.nil? || e.longitude.nil? }
    gon.event_types = EventType.all
    gon.event_images = []
    gon.times = []
    gon.addresses = []
    gon.event_ids = []
    gon.event_pks = []
    gon.locale = I18n.locale.to_s
    gon.events.each do |e|
      gon.event_pks << e.id
      gon.event_ids << e.to_param
      gon.addresses << e.location
      gon.times << e.formatted_time
      gon.event_images << ActionController::Base.helpers.asset_path(e.image.url)
    end
  end

  def load_event
    @event = Event.find_by_param params[:id]
  end

  def load_movement
    if params[:movement_id]
      @movement = Movement.find_by_param params[:movement_id]
    else
      @movement = @event.movement
    end
  end

  def load_all_movements
    @movements = Movement.all.published
  end

  def load_event_types
    @event_types = EventType.all.map {|e| [e.id, e.name]}
  end

  def redirect_unauthorized_user
    unless @event.host?(current_user)
      redirect_to root_path, notice: t('event.not_yours')
    end
  end
end
