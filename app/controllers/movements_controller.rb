class MovementsController < ApplicationController
  skip_before_filter :check_request_exception
  prepend_before_filter :return_404_on_json_errors
  before_filter :load_movement, except: [:new, :create, :index, :my_profile, :new_submovement, :my_groups, :check_name, :cancel_ownership, :cancel_membership]
  before_filter :load_movements, only: [:index, :search]

  include YoutubeParserHelper
  include ZipHelper

  def index
    @movement = Movement.first
    load_countdown_urls
    render 'movements/show'
  end

  def my_profile
    redirect_to root_path and return unless current_user
    @events_attending = current_user.events_attending
    @events_hosting = current_user.approved_events
    @teams_coordinating = current_user.movements
    @my_teams = current_user.teams
    respond_to do |format|
      format.html {render action: 'my_profile'}
      format.js
    end
  end

  def my_groups
    redirect_to root_path and return unless current_user
    @groups = current_user.movements_and_groups
    @group = params[:name] ? Movement.find(params[:name][:id]) : @groups.first
    @congo_week = @group && @group.name == "Congo Week"
    redirect_to root_path and return unless @groups.include?(@group)

    respond_to do |format|
      format.html {render action: 'my_groups'}
      format.js
    end

    @movement = @groups.first
    @events = @movement.events
  end

  def new
    redirect_to new_user_session_path and return unless current_user
    @movement = Movement.new
  end

  def create
    params[:movement][:parent_id] = Movement.first.id if Movement.first
    @movement = Movement.new(movement_params)
    if @movement.save
      unless current_user.nil?
        NewTeamMailWorker.perform_async(current_user.id, @movement.id) if ENV["RAILS_ENV"] == "production"
        @movement.users << current_user
      end
      redirect_to movement_explanation_path(@movement)
      flash[:notice] = t('movement.created')
    else
      render :new, alert: t('movement.not_created')
    end
  end

  def show
    redirect_to root_path and return unless @movement

    if @movement.parent.nil?
      render "show"
    else
      render "show_team"
    end
  end

  def join_team
    @team_id = params[:id].split("-").last
    redirect_to new_member_user_path({:team => @team_id})
  end

  def cancel_ownership
    @team = Movement.find params[:team_id]
    @coordinator = User.find params[:coordinator_id]
    ownership = @coordinator.ownerships.find_by(movement_id: @team.id)
    ownership.destroy if ownership
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def destroy
    authenticate_user!
    UserMailer.delete_movement_message(@movement.id)

    @team = Movement.find params[:id].split("-").last
    @team.destroy

    redirect_to :back, notice: t('movement.deleted')
  end

   def cancel_membership
    @team = Movement.find params[:team_id]
    @member = User.find params[:member_id]
    membership = @member.memberships.find_by(movement_id: @team.id)
    membership.destroy if membership
    respond_to do |format|
      format.html { render nothing: true }
      format.js
    end
  end

  def export_csv
    send_data @movement.to_csv, filename: "#{@movement.name} attendee-list.csv"
  end

  def export_hosts_csv
    send_data @movement.hosts_to_csv, filename: "#{@movement.name} host-list.csv"
  end

  def export_coordinators_csv
    send_data @movement.coordinators_to_csv, filename: "#{@movement.name} coordinator-list.csv"
  end

  def export_all_csv
    send_data @movement.all_to_csv, filename: "#{@movement.name} supporter-list.csv" if current_user.super_admin?
  end

  def export_members_csv
    send_data @movement.members_to_csv, filename: "#{@movement.name} members-list.csv"
  end

  def publish
    @movement.publish
    respond_to do |format|
      format.html { redirect_to movement_path(@movement), notice: t('movement.published')}
      format.js
    end
  end

  def update
    @movement.update_attributes(movement_params)
    redirect_to request.referer
  end

  def support_network
    @support_network =  Movement.where(parent_id: @movement)
  end

  def check_name
    @movement = Movement.find_by_name(params[:movement][:name])

    respond_to do |format|
      format.json {render :json => !@movement}
      format.js
    end
  end

  def explanation; end

  private


  def movement_params
    params[:movement][:video]= extract_video_id(params[:movement][:video]) unless @movement && (@movement.video == params[:movement][:video] || params[:movement][:video].nil?)
    (@movement && @movement.name == "Congo Week") ? params.require(:movement).permit(:category, :tagline, :call_to_action, :extended_description, :image, :avatar, :video, :about_creator, :website, :flickr, :parent_id, :location, :sponsored) : params.require(:movement).permit(:name, :category, :tagline, :call_to_action, :extended_description, :image, :avatar, :video, :about_creator, :website, :flickr, :parent_id, :location, :sponsored)
  end

  def load_movements
    @movements = Movement.all.published.where(parent_id: nil)
  end

  def load_movement
    @movement = Movement.find_by_param params[:id]
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, notice: t('movement.no_route')
  end

  def load_event_types
    @event_types = EventType.names
  end

  def load_countdown_urls
    @countdown_urls = {
                        en: "http://free.timeanddate.com/countdown/i4a6f1qx/n64/cf12/cm0/cu4/ct1/cs0/ca0/co0/cr0/ss0/cacfff/cpcfff/pct/tcfff/fs200/szw576/szh243/iso2014-10-19T00:00:00",
                        es: "http://free.timeanddate.com/countdown/i4a6f1qx/n64/cf12/cm0/cu4/ct1/cs0/ca0/co0/cr0/ss0/cacfff/cpcfff/pct/tcfff/fs200/szw576/szh243/iso2014-10-19T00:00:00",
                        fr: "http://free.timeanddate.com/countdown/i4a6f1qx/n64/cf12/cm0/cu4/ct1/cs0/ca0/co0/cr0/ss0/cacfff/cpcfff/pct/tcfff/fs200/szw576/szh243/iso2014-10-19T00:00:00"
                      }
  end

  def check_user_owns_movement
    unless @movement.users.to_a.include? current_user
      redirect_to root_path, alert: t('movement.not_yours')
    end
  end

  def return_404_on_json_errors
    if e = request_exception && e.is_a?(ActiveSupport::JSON::ParseError)
      head 404
    else
      return
    end
  end

end
