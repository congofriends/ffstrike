class EventsController < ApplicationController
  before_filter :load_movement, :only => [:new, :create]
  before_filter :load_event, :only => [:explanation, :show, :update, :approve, :destroy]
  before_filter :authenticate_user!, :only => [:new, :destroy]
  after_filter :populate_tasks, :only => [:create]

  include ZipHelper

  def explanation; end

  def new
    @event = Event.new      
  end

  def approve
    @event.update_attribute(:approved, !@event.approved)
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def show
    respond_to do |format|
      format.html
      format.pdf do
        case params[:generate]
        when 'event' then generate_pdf('events/show', 'event_details.pdf')
        when 'tasks' then generate_pdf('tasks/index', 'event_tasks.pdf')
        end
      end
    end
  end

  def create
    @event = @movement.events.build(event_params)
    if @event.save
      @event.update_attributes(approved: current_user == @movement.user, host: current_user)
      if current_user == @movement.user
        flash[:notice] = "Event created!"
        redirect_to explanation_path(@event) and return
      end
      flash[:notice] = "Your event will be viewable to the public as soon as the movement coordinator approves it!"
      redirect_to explanation_path(@event) and return
    else
      flash[:notice] = @event.errors.full_messages.flatten.join(' ')
      if current_user == @movement.user
       redirect_to dashboard_movement_path(@movement, anchor: "events") and return
      end
      redirect_to visitor_path(@movement) and return
    end
  end
  
  def search
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = Event.near_zip(@zip, 200)
  end

  def update
    @event.update_attributes(event_params)
    flash[:notice] = "Event updated."
    respond_to do |format|
      format.html { redirect_to dashboard_movement_path(@event.movement, anchor: "events") }
      format.json { head :ok }
    end
  end

  def destroy 
    @event.destroy
    flash[:notice] = "Event deleted."
    respond_to do |format|
      format.html { redirect_to dashboard_movement_path(@event.movement, anchor: "events") }
      format.js
    end
  end

  private

  def event_params
    # params[:event][:event_type] = TaskPopulator.event_type(params[:event][:event_type])
    params.require(:event).permit(:event_type, :name, :address, :location_details, :city, :zip, :date, :time, :coordinator_id, :notes)
  end

  def load_event
    @event = Event.find(params[:id])
  end

  def load_movement
    @movement = Movement.find params[:movement_id]
  end

  def populate_tasks
    TaskPopulator.assign_tasks @event 
  end

  def generate_pdf(view_name, final_doc_name)
    pdf = PDFKit.new(render_to_string(view_name), :page_size=>'Letter').to_pdf
    send_data(pdf, filename: final_doc_name, type: 'application/pdf', disposition: 'inline')
  end
end
