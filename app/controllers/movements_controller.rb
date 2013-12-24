class MovementsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :load_movement, :except => [:new, :create]
  include YoutubeParserHelper

  def index; end

  def new
    @movement = Movement.new
  end

  def create
    @movement = Movement.new(movement_params)

    if @movement.save
      unless current_user.nil?
        current_user.add_movement(@movement)
      end
      flash[:notice] = "Congratulations! Your movement was created. Try starting some rallies."
      redirect_to movement_path(@movement)
    else
      flash[:notice] = "There was an problem when saving your movement. Please try again."
      render :new 
    end
  end

	def show; 
  end

  def update
    @movement.update_attributes(movement_params)
    redirect_to movement_path(@movement) 
  end

  private
  
  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video])
    params.require(:movement).permit(:name, :category, :story, :image, :video)
  end

  def load_movement
		@movement = Movement.find(params[:id])		
  end
end
