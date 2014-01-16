class AttendeesController < ApplicationController
  before_filter :load_rally_and_movement, :only => [:create]

  def create
    @attendee = @rally.attendees.build(attendee_params)
      if @attendee.save
      redirect_to movement_rally_path(@movement, @rally), notice: "You signed up for the rally"
    else
      redirect_to movement_path(@movement, anchor: "rallies"),  notice: "Email is required"
    end
  end

  private
  def attendee_params
    params.require(:attendee).permit(:name, :email)
  end

  def load_rally_and_movement 
    @rally = Rally.find params[:rally_id]
    @movement = @rally.movement
  end
end
