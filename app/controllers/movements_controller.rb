class MovementsController < ApplicationController
  before_filter :authenticate_user!

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
    params.require(:movement).permit(:name, :category, :story, :image)
  end
end
