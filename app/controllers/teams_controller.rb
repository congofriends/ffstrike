class TeamsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
    @team = Team.find(params[:id])
    if @team.coordinator.user == current_user
      render "coordinator_dashboard"
    end
  end

  def apply
    @team_id = params[:id]
    @role_application = RoleApplication.new(:role => params[:role])
  end

  def role_application
    team = Team.find(params[:id])
    team.role_applications << RoleApplication.new(params[:role_application].to_hash)
    team.save

    redirect_to wait_team_path(params[:id])
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
    @team_id = params[:id]
  end
end
