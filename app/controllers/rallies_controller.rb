class RalliesController < ApplicationController
  def new
    @rally = Rally.new      
    @movement = Movement.find params[:movement_id]
  end

  def create
    @movement = Movement.find params[:movement_id]
    @rally = @movement.rallies.build(rally_params)
    flash[:notice] = 
      @rally.save ? "Rally created!" : @rally.errors.full_messages.flatten.join(' ')
    redirect_to movement_path(@movement, anchor: "rallies")
  end
  
  private

  def rally_params
    params.require(:rally).permit(:address, :city, :zip, :coordinator_id, :notes)
  end
end
