class MovementsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visitor]
  before_filter :load_movement, :except => [:new, :create, :index, :user_movements]
  include YoutubeParserHelper

  def visitor
    @events = @movement.events
  end

  def index
    @movements = Movement.all
  end

  def user_movements
    @movements = current_user.movements
  end

  def dashboard
    @event = Event.new
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
      flash[:notice] = "Congratulations! You just created a movement, try to create event type"
      redirect_to movement_path(@movement)
    else
      flash[:notice] = "There was an problem when saving your movement. Please try again."
      render :new 
    end
  end

	def show
    @events = @movement.events
  end

  def export_csv
    send_data @movement.to_csv, filename: "Attendee List"
  end

  def update
    @movement.update_attributes(movement_params)
    redirect_to movement_path(@movement) 
  end

  private
  
  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video])
    params.require(:movement).permit(:name, :category, :story, :image, :video, :user_id)
  end

  def load_movement
		@movement = Movement.find(params[:id])		
  end
end
