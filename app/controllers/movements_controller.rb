class MovementsController < ApplicationController
  before_filter :load_movement, except: [:new, :create, :index, :my_profile, :new_submovement, :my_groups, :check_name]
  before_filter :load_movements, only: [:index, :search]

  include YoutubeParserHelper
  include ZipHelper

  def index
    # redirect_to movement_path(Movement.first)
    @movement = Movement.first
    render 'movements/show'
  end

  def search
    #FIXME: refactor this method here and in the events_controller, currently it
    #is just clear duplication
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = @movement.events.near_zip(@zip, 200)
    render 'events/search'
  end

  def my_profile
    redirect_to root_path and return unless current_user
    @events_attending = current_user.events_attending
    @events_hosting = current_user.approved_events
  end

  def my_groups
    redirect_to root_path and return unless current_user
    @groups = current_user.movements_and_groups
    @group = params[:name] ? Movement.find(params[:name][:id]) : @groups.first
    redirect_to root_path and return unless @groups.include?(@group)

    respond_to do |format|
      format.html {render action: 'my_groups'}
      format.js
    end

    @movement = @groups.first
    @events = @movement.events
  end

  def new
    redirect_to new_user_session_path and return unless current_user
    @movement = Movement.new
  end

  def create
    params[:movement][:parent_id] = Movement.first.id if Movement.first
    @movement = Movement.new(movement_params)
    if @movement.save
      unless current_user.nil?
        UserMailer.team_creation_message(current_user.id, @movement.id) if current_user
        @movement.users << current_user
      end
      redirect_to movement_explanation_path(@movement), notice: t('movement.created') and return
    else
      render :new, notice: t('movement.not_created')
    end
  end

  def show
    return if redirect_unauthorized_user
    load_event_types
    get_approved_events
    load_map_vars

    @sub_events = []
    @movement.sub_movements.each { |sub_movement| @sub_events.concat sub_movement.events }

    if @movement.parent.nil?
      render "show"
    else
      render "show_chapter"
    end

  end

  def export_csv
    send_data @movement.to_csv, filename: "#{@movement.name} attendee-list.csv"
  end

  def export_hosts_csv
    send_data @movement.hosts_to_csv, filename: "#{@movement.name} host-list.csv"
  end

  def export_all_csv
    send_data @movement.all_to_csv, filename: "#{@movement.name} supporter-list.csv" if current_user.super_admin?
  end

  def publish
    @movement.publish
    respond_to do |format|
      format.html { redirect_to movement_path(@movement), notice: t('movement.published')}
      format.js
    end
  end

  def update
    @movement.update_attributes(movement_params)
    redirect_to request.referer
  end

  def event_type
    load_event_types
  end

  def support_network
    @support_network =  Movement.where(parent_id: @movement)
  end

  def check_name
    @movement = Movement.find_by_name(params[:movement][:name])

    respond_to do |format|
      format.json {render :json => !@movement}
      format.js
    end
  end

  def explanation; end

  private


  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video]) if !params[:movement][:video].nil?
    params.require(:movement).permit(:name, :category, :tagline, :call_to_action, :extended_description, :image, :avatar, :video, :about_creator, :website, :flickr, :parent_id, :location, :sponsored)
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

  def load_map_vars
    gon.events = @movement.events.reject { |e| e.latitude.nil? || e.longitude.nil? }
    gon.event_types = EventType.all
    gon.event_images = []
    gon.times = []
    gon.addresses = []
    gon.event_ids = []
    gon.event_pks = []
    gon.events.each do |e|
      gon.event_pks << e.id
      gon.event_ids << e.to_param
      gon.addresses << e.location
      gon.times << e.formatted_time
      gon.event_images << ActionController::Base.helpers.asset_path(e.image.url)
    end
  end

  def get_approved_events
    @approved_events = @movement.events.select {|e| e.approved == true}
  end

  def check_user_owns_movement
    unless @movement.users.to_a.include? current_user
      redirect_to root_path, notice: t('movement.not_yours')
    end
  end

  def redirect_unauthorized_user
    unless @movement.authorized?(current_user)
      redirect_to root_path, notice: t('movement.not_public')
      return true
    end
    return false
  end
end
