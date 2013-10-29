class TeamsController < ApplicationController
  before_filter :authenticate_user!, :except => [:index, :create_team_info, :join_team_info]

  def index
    unless params[:zip] and params[:distance]
      @teams = Team.all
    else
      @zip = params[:zip]
      @distance = params[:distance]
      @teams = Team.near(@zip, @distance)
      flash.now[:notice] = "No teams have been found in this area. Try another zip or distance value" if Team.where(zip: params[:zip]).count == 0
    end
  end

  def show
    @team = Team.find(params[:id])
      if @team.coordinator.user == current_user && params[:role].nil?
        @friends = []
        render "coordinator_dashboard"
      else
        if params[:role]
           @role =  @team.role_applications.where(:role => params[:role]).first
        else
          @role = @team.role_applications.where(:user => current_user).first
        end
      render "role_dashboard"
      end
  end

  def create_team_info
  end

  def join_team_info
  end

  def apply
    @team_id = params[:id]
    @role_application = "#{params[:role]}_application".camelcase.constantize.new(:role => params[:role])
  end
  
  def disband
    @team = Team.find(params[:id])
    @team.destroy

    redirect_to root_path
  end

  def my_teams
    @current_user_teams = []
    @current_user_teams.uniq!
    Team.where("coordinator.user_id" => current_user.id).each do |team|
      @current_user_teams << team
    end
    all_user_teams = Team.where("role_applications.user_id" => current_user.id)  
      all_user_teams.each do |team|
          @current_user_teams << team if team.approved_application_exists? current_user.id
      end
  end

  def team_details
    @teams = Team.where(:"coordinator.user_id" => current_user.id)
    # @team = Team.find(params[:id])
  end

  def facebook_friends
    oauth_access_token = User.authentication_token
    @graph = Koala::Facebook::API.new(oauth_access_token)
    @friends = @graph.get_connections("me", "friends")
  end

  def create_role_application
    team = Team.find(params[:id])

    role_application = "#{params[:role_application][:role]}_application".camelcase.constantize.new(params[:role_application].to_hash)
    role_application.user = current_user

    team.role_applications << role_application
    if team.save
      redirect_to wait_team_path(params[:id])
    else
      flash.now[:danger] = role_application.errors.messages.values.flatten.first if role_application.errors.messages.count != 0
      @team_id = params[:id]
      @role_application = "#{params[:role_application][:role]}_application".camelcase.constantize.new(params[:role_application].to_hash)
      render 'apply'
    end
  end

  def take_responsibility
    @team = Team.find(params[:id])
    
    role_application = "#{params[:role]}_application".camelcase.constantize.new(:role => params[:role])
    role_application.user = current_user
    role_application.approved = true

    @team.role_applications << role_application
    @team.save

    @friends = []
    redirect_to root_path
  end

  def view_role_application
    @team = Team.find(params[:id])
    @role_application = @team.role_applications.find(params[:role_application_id])
  end

  def review_role_application
    team = Team.find(params[:id])
    role_application = team.role_applications.find(params[:role_application_id])

    role_application.approved = (params[:status] == 'approve')
    role_application.rejected = (params[:status] == 'reject')
    role_application.save
    redirect_to :team
  end

  def reassign
    @team = Team.find(params[:id])
    @role = @team.role_applications.find(params[:role_application_id])
  end

  def reassign_team_member
    @team = Team.find(params[:id])
    role_application = @team.role_applications.find(params[:role_application_id])
    role_application.role = params[:role].downcase 
    role_application.tasks = DriverApplication.new.tasks if params[:role].downcase == 'driver' 
    role_application.tasks = PrinterApplication.new.tasks if params[:role].downcase == 'printer'
    role_application.tasks = MapperApplication.new.tasks if params[:role].downcase == 'mapper'
    role_application.save
    @friends = []

    render 'coordinator_dashboard'
  end
    

  def cancel_role_application
    team = Team.find(params[:id])
    role_application = team.role_applications.find(params[:role_application_id])
    role_application.destroy

    redirect_to root_path
  end

  def wait
  end

  def new
    @team = Team.new :coordinator => Coordinator.new
  end

  def edit
    @team = Team.find(params[:id])
  end

  def create
    team = Team.new(params[:team].to_hash)
    team.coordinator.user = current_user
    if team.save
      redirect_to invite_team_url(:id => team.id)
    else
      flash.now[:danger] = team.errors.messages.values.flatten.first
      flash.now[:danger] = team.coordinator.errors.messages.values.flatten.first
      @team = Team.new :coordinator => Coordinator.new
      render "new" 
    end
  end

  def invite
    @team_id = params[:id]
  end

  def join
    @team = Team.find(params[:id])
  end

  def update
    puts params.inspect
    @team = Team.find(params[:id])
    @team.update_attributes(team_params)
    # @team.update_attributes!(:map => params[:team][:map].to_sym)

    @role = @team.role_applications.where(:user => current_user).first
    @teams =  Team.where(:"coordinator.user_id" => current_user.id) 
    flash.now[:notice] = "Team information has been updated"
    render 'team_details'
  end

  def team_tasks
    @team = Team.find(params[:id])
  end

  private
    def team_params
      params.require(:team).permit(:name, :city, :zip, :map, :coordinator => [:where, :why], :coordinator_attributes => [:tasks_attributes => [:id, :description] ])
    end
end
