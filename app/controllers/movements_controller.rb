class MovementsController < ApplicationController
  before_filter :authenticate_user!
  include YoutubeParserHelper

  def new
    @movement = Movement.new
  end

  def create
    @movement = Movement.new(movement_params)
    if @movement.save
      redirect_to movement_path(@movement)
    else
      render :new
    end
  end

	def show
		@movement = Movement.find(params[:id])		
	end

  private
  
  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video])
    params.require(:movement).permit(:name, :category, :story, :image, :video)
  end

end
