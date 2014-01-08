require 'spec_helper'

describe MailController do

  before :each do
    @movement = FactoryGirl.create(:movement)
    @rally = FactoryGirl.create(:rally)
    @attendee = FactoryGirl.create(:attendee, movement_id: @movement.id, rally_id: @rally.id)
  end

  describe "POST #mail" do
    it "tells usermailer to mail" do
      post :mail_movement, movement_id: @movement, message: "TestMessage"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_rally" do
    it "tells usermailer to mail_rally" do
      post "mail_rally", rally_id: @rally, movement_id: @rally, message: "Test Message"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end 
end
