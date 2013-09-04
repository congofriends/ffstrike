class HomeController < ApplicationController
  before_filter :authenticate_user!

  def start
    current_team = Team.where(:coordinator => current_user, :active => true)
    if current_team.exists?
      redirect_to team_url(:id => current_team.first.id)
    end
  end
end
