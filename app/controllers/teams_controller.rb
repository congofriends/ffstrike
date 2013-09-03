class TeamsController < ApplicationController
  before_filter :authenticate_user!

  def index
  end

  def show
  end

  def apply
  end

  def wait
  end

  def new
    @team = Team.new
  end

  def create
    team_params = params[:team].to_hash.merge(:coordinator => current_user)
    team = Team.create(team_params)
    redirect_to teams_invite_url(:id => team.id)
  end

  def invite
  end
end
