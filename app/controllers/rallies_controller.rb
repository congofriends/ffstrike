class RalliesController < ApplicationController
  def new
    @rally = Rally.new      
    @movement = Movement.find params[:movement_id]
  end

  def create
    @movement = Movement.find params[:movement_id]
    @rally = Rally.new(rally_params.merge(movement_id: @movement.id))
    if @rally.save 
      flash[:notice] = "Rally created!"
    else
      flash[:notice] = @rally.errors.full_messages.flatten.join(' ')
    end
      redirect_to movement_path(@movement)
  end
  
  private

  def rally_params
    params.require(:rally).permit(:address, :city, :zip, :coordinator_id, :notes)
  end
end
