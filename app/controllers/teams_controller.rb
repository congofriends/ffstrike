class TeamsController < ApplicationController
  before_filter :authenticate_user!

  def index
    unless params[:zip] and params[:distance]
      @teams = Team.all
    else
      @zip = params[:zip]
      @distance = params[:distance]
      @teams = Team.near(@zip, @distance)
    end
  end

  def show
    @team = Team.find(params[:id])
    if @team.coordinator.user == current_user
      render "coordinator_dashboard"
    else
      @role = @team.role_applications.where(:user => current_user).first
      render "role_dashboard"
    end
  end

  def apply
    @team_id = params[:id]
    @role_application = "#{params[:role]}_application".camelcase.constantize.new(:role => params[:role])
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
    team.save

    redirect_to wait_team_path(params[:id])
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

  def create
    team = Team.new(params[:team].to_hash)
    team.coordinator.user = current_user
    team.save

    redirect_to invite_team_url(:id => team.id)
  end

  def invite
    @team_id = params[:id]
  end

  def join
    @team = Team.find(params[:id])
  end
end
