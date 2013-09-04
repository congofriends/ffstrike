class HomeController < ApplicationController
  def start
    unless current_user.nil?
      current_team = Team.any_in(:'coordinator.user_id' => current_user.id)
      if current_team.exists?
        redirect_to team_url(:id => current_team.first.id)
      end
    end
  end
end
