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
  end

  def create
    team = Team.create(params[:team].to_hash)
    redirect_to teams_invite_url(:id => team.id)
  end

  def invite
  end
end
