class MovementsController < ApplicationController
  before_filter :authenticate_user!, except: [:visitor, :search, :index, :show]
  before_filter :load_movement, except: [:new, :create, :index, :user_movements]
  before_filter :load_event_types, only: [:visitor, :show]
  before_filter :get_assosiated_movement, :only => [:visitor, :show]

  include YoutubeParserHelper
  include ZipHelper

  def visitor
  end

  def index
    @movements = Movement.published
  end

  def search
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = @movement.events.near_zip(@zip, 200)
    render 'events/search'
  end

  def user_movements
    @movements = current_user.movements
  end

  def dashboard
    @event = Event.new
    @event_types = EventType.all.map {|e| [e.id, e.name]}
  end

  def new
    @movement = Movement.new
  end

  def create
    @movement = Movement.new(movement_params)
    @movement.user_id = current_user.id
    if @movement.save
      unless current_user.nil?
        current_user.add_movement(@movement)
      end
      unless movement_params[:draft] == 1
        @movement.publish
      end
      flash[:notice] = "Congratulations, you just created a movement!"
      redirect_to movement_path(@movement)
    else
      flash[:notice] = "There was an problem when saving your movement. Please try again."
      render :new 
    end
  end

	def show; end

  def export_csv
    send_data @movement.to_csv, filename: "Attendee List"
  end

  def publish
    @movement.publish
    respond_to do |format|
      format.html { redirect_to movement_path(@movement), notice: "Movement has been published" }
      format.js
    end
  end

  def update
    @movement.update_attributes(movement_params)
    redirect_to movement_path(@movement) 
  end

  private
  
  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video])
    params.require(:movement).permit(:name, :draft, :category, :tagline, :call_to_action, :extended_description, :image, :video, :user_id)
  end

  def load_movement
		@movement = Movement.find(params[:id])
  end

  def load_event_types
    @event_types = EventType.names
  end

  def get_assosiated_movement
    @events = @movement.events
  end
end
