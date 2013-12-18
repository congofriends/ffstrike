class RalliesController < ApplicationController
  def new
    @rally = Rally.new      
  end

  def create
    @rally = Rally.new(rally_params)
    if @rally.save 
      flash[:notice] = "Rally created!"
      redirect_to movement_path(Movement.find_by_id(params[:movement_id]))
    else
      flash[:notice] = "Rally was not created."
      render :new
    end
  end
  
  private

  def rally_params
    params.require(:rally).permit(:address, :city, :zip, :coordinator_id, :notes)
  end
end
