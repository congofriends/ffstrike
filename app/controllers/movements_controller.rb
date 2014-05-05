class MovementsController < ApplicationController
  before_filter :authenticate_user!, except: [:search, :index, :show]
  before_filter :load_movement, except: [:new, :create, :index, :user_movements, :new_submovement]
  before_filter :load_movements, only: [:index, :search]
  before_filter :load_event_types, only: [:show]
  before_filter :get_approved_events, only: [:show]
  before_filter :check_user_owns_movement, only: [:dashboard]
  before_filter :redirect_unauthorized_user, only: [:show]
  before_filter :clear_session_parent_id, except: [:create]

  include YoutubeParserHelper
  include ZipHelper

  def index; end

  def search
    #FIXME: refactor this method here and in the events_controller, currently it
    #is just clear dublication
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = @movement.events.near_zip(@zip, 200)
    @attendee = Attendee.new
    render 'events/search'
  end

  def user_movements
    @movements = current_user.movements
    @events = current_user.approved_events
    @unapproved_events = current_user.nonapproved_events
  end

  def dashboard
    session[:movement] = @movement.id
    @event = Event.new
    @events = @movement.events
    @event_types = EventType.all.map {|e| [e.id, e.name]}
  end

  def new
    @movement = Movement.new
  end

  def new_submovement
    session[:parent_id] = session[:movement_id]
    @movement = Movement.new
    render :new
  end

  def create
    @movement = Movement.new(movement_params)
    if @movement.save
      unless current_user.nil?
        @movement.users << current_user
      end
      unless movement_params[:draft] == "1"
        @movement.publish
      end
      redirect_to movement_path(@movement), notice: t('movement.created')
    else
      render :new, notice: t('movement.not_created')
    end
  end

  def show
    gon.events = @movement.events.reject { |e| e.latitude.nil? || e.longitude.nil? }
    session[:movement_id] = @movement.id
    @sub_events = []
    @movement.sub_movements.each { |sub_movement| @sub_events.concat sub_movement.events }
  end

  def export_csv
    send_data @movement.to_csv, filename: "Attendee List"
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
    redirect_to movement_path(@movement), notice: t('movement.updated')
  end

  private
  def clear_session_parent_id
    session[:parent_id] = nil
  end

  def movement_params
    params[:movement][:parent_id] ||= session[:parent_id]
    params[:movement][:video]= extract_video_id(params[:movement][:video]) if !params[:movement][:video].nil?
    params.require(:movement).permit(:name, :draft, :category, :tagline, :call_to_action, :extended_description, :image, :video, :about_creator, :parent_id, :location)
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
    end
  end
end
