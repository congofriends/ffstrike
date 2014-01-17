class MovementsController < ApplicationController
  before_filter :authenticate_user!, :except => [:visitor]
  before_filter :load_movement, :except => [:new, :create, :index]
  include YoutubeParserHelper

  def visitor
  end

  def index
    @movements = Movement.where(user_id: current_user.id)
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
      flash[:notice] = "Congratulations! Your movement was created. Try starting some events."
      redirect_to movement_path(@movement)
    else
      flash[:notice] = "There was an problem when saving your movement. Please try again."
      render :new 
    end
  end

	def show
    @event = Event.new
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
