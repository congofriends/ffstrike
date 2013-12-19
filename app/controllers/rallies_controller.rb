class RalliesController < ApplicationController
  def new
    @rally = Rally.new      
    @movement = Movement.find params[:movement_id]
  end

  def create
    @rally = Rally.new(rally_params)
    @movement = Movement.find params[:movement_id]
    if @rally.save 
      flash[:notice] = "Rally created!"
      redirect_to movement_path(@movement)
    else
      flash[:notice] = @rally.errors.full_messages.flatten.join
      render :new
    end
  end
  
  def show
    @rally = Rally.find(params[:id])
  end

  private

  def rally_params
    params.require(:rally).permit(:address, :city, :zip, :coordinator_id, :notes)
  end
end
