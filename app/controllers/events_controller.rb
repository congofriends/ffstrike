class EventsController < ApplicationController
  before_filter :load_event, :only => [:approve, :show, :update, :destroy, :explanation, :edit, :dashboard, :download]
  before_filter :load_movement, :only => [:new, :create, :edit, :update, :dashboard, :index]
  before_filter :redirect_unauthorized_user, :only => [:dashboard, :edit]
  before_filter :load_event_types, :only => [:edit, :dashboard]

  include ZipHelper

  def new
    @event = Event.new
  end

  def index
    @events = @movement.events.where(approved: true)
    @events = @events.query_results(params[:query]) if params[:query].present?

    respond_to do |format|
      if params[:query].present?
        format.html {redirect_to movement_events_path}
        format.js
      else
        format.html { render action: "index" }
      end
    end
  end

  def approve
    @event.update(approved: !@event.approved)
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def show
    load_all_movements

    respond_to do |format|
      format.html do
        render 'show' unless @event.attendees.include?(current_user)
        render 'attendee' if @event.attendees.include?(current_user)
      end

      format.pdf do
        case params[:generate]
          when 'event' then generate_pdf('events/show', 'event_details.pdf')
          when 'tasks' then generate_pdf('tasks/index', 'event_tasks.pdf')
        end
      end
    end
  end

  def create
    @movement = Movement.find_by_name(params["event"]["movement"]) if params["event"]["movement"] && params["event"]["movement"] != ""
    @event = @movement.events.build(event_params)
    if @event.save
      @event.assign_host_and_approve(current_user)
      if @movement.users.include?(current_user)
        redirect_to explanation_path(@event), notice: t('event.created') and return
      end
      redirect_to explanation_path(@event), notice: t('event.created_by_attendee') and return
    else
      flash[:notice] = @event.errors.full_messages.flatten.join(' ')
      if @movement.users.include?(current_user)
       redirect_to dashboard_movement_path(@movement, anchor: "events") and return
      end
      redirect_to movement_path(@movement) and return
    end
  end

  def search
    #FIXME: refactor this method here and in the movements_controller, currently it
    #is just clear duplication
    @zip ||= extract_zip(params[:zip]) if valid_zip(params[:zip])
    @events = Event.near_zip(@zip, 200)
  end

  def update
    if @event.update_attributes(event_params)

      # params[:flyer].each {|attachment| @event.attachments.create(flyer: attachment)}
      # @event.attachments.create(flyer: params[:flyer]) if params[:flyer]
      flash[:notice] = t('event.updated')
    end

    respond_to do |format|
      if @event.movement.users.include?(current_user)
        format.html { redirect_to dashboard_movement_path(@event.movement, anchor: "events")}
      else
        format.html { redirect_to event_path(@event) }
      end
        format.json { head :ok }
        format.js
    end
  end

  def destroy
    authenticate_user!
    UserMailer.delete_event_message(@event)
    @event.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_movement_path(@event.movement, anchor: "events"), notice: t('event.deleted') }
      format.js
    end
  end

  def explanation; end

  def search_by_keyword; end

  def edit; end

  def dashboard; end

  private

  def event_params
    params[:event][:event_type_id] = EventType.find_by(name: params[:event][:event_type]).id if params[:event][:event_type]
    params.require(:event).permit(:event_type_id, :address2, :name, :address, :location_details, :description, :city, :zip, :state, :start_time, :image, :flyer, :end_time, :host_id, :notes, :forum_option, :approved)
  end

  def load_event
    @event = Event.find_by_param params[:id]
  end

  def load_movement
    if params[:movement_id]
      @movement = Movement.find_by_param params[:movement_id]
    else
      @movement = @event.movement
    end
  end

  def load_all_movements
    @movements = Movement.all.published
  end

  def load_event_types
    @event_types = EventType.all.map {|e| [e.id, e.name]}
  end

  def generate_pdf(view_name, final_doc_name)
    pdf = PDFKit.new(render_to_string(view_name), :page_size=>'Letter').to_pdf
    send_data(pdf, filename: final_doc_name, type: 'application/pdf', disposition: 'inline')
  end

  def redirect_unauthorized_user
    unless @event.host?(current_user)
      redirect_to root_path, notice: t('event.not_yours')
    end
  end
end
