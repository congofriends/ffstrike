class HomeController < ApplicationController
  def start
    if user_signed_in?
      coordinating_team = Team.any_in(:'coordinator.user_id' => current_user.id)
      if coordinating_team.exists?
        redirect_to team_url(:id => coordinating_team.first.id)
      else
        on_team = Team.any_in(:'role_applications.user_id' => current_user.id)
        if on_team.exists?
          redirect_to team_url(:id => on_team.first.id)
        end
      end
    end
  end
end
