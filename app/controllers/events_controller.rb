class EventsController < ApplicationController
  before_filter :load_movement, :only => [:new, :create, :show]

  include EventsHelper

  def new
    @event = Event.new      
  end

  def show
    @event = Event.find params[:id]
  end

  def create
    @event = @movement.events.build(event_params)
    flash[:notice] = 
      @event.save ? "Event created!" : @event.errors.full_messages.flatten.join(' ')
    redirect_to movement_path(@movement, anchor: "events")
  end
  
  def search
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = Event.near_zip(@zip, 200)
  end

  private

  def event_params
    params.require(:event).permit(:name, :address, :city, :zip, :coordinator_id, :notes)
  end

  def load_movement
    @movement = Movement.find params[:movement_id]
  end
end
