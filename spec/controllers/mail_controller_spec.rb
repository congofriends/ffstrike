require 'spec_helper'

describe MailController do

  before :each do
    attendee = FactoryGirl.create(:attendee, movement_id: "1", rally_id: "1")
  end

  describe "POST #mail" do
    it "tells usermailer to mail" do
      post "mail_movement", movement_id: "1", message: "TestMessage"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_rally" do
    it "tells usermailer to mail_rally" do
      post "mail_rally", rally_id: "1", movement_id: "1", message: "Test Message"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end 
end
