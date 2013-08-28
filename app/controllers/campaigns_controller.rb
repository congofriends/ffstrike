class CampaignsController < ApplicationController
  before_filter :authenticate_user!

  def show
    @campaign = Campaign.find(params[:campaign_id])
  end
end
