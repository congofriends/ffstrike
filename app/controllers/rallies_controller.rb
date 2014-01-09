class RalliesController < ApplicationController
  before_filter :load_movement, :only => [:new, :create, :show]

  include RalliesHelper

  def new
    @rally = Rally.new      
  end

  def show
    @rally = Rally.find params[:id]
  end

  def create
    @rally = @movement.rallies.build(rally_params)
    flash[:notice] = 
      @rally.save ? "Rally created!" : @rally.errors.full_messages.flatten.join(' ')
    redirect_to movement_path(@movement, anchor: "rallies")
  end
  
  def search
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @rallies = Rally.near_zip(@zip, 200)
  end

  private

  def rally_params
    params.require(:rally).permit(:name, :address, :city, :zip, :coordinator_id, :notes)
  end

  def load_movement
    @movement = Movement.find params[:movement_id]
  end
end
