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

    redirect_to teams_invite_url(:id => team.id)
  end

  def invite
  end
end
