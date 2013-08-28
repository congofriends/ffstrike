class RolesController < ApplicationController
  before_filter :authenticate_user!

  def index
    campaign_id = params[:campaign_id]
    @roles = Role.where(:campaign_id => campaign_id)
  end

  def show
  end
end
