class EventsController < ApplicationController
  before_filter :load_movement, :only => [:new, :create, :show]
  before_filter :authenticate_user!, :only => [:new]

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
    if current_user == @movement.user
      redirect_to movement_path(@movement, anchor: "events")
      return
    end
    redirect_to visitor_path(@movement)
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
