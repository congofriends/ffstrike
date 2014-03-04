require 'spec_helper'

describe MailController do

  let!(:movement) { FactoryGirl.create(:movement) }
  let!(:event) { FactoryGirl.create(:event, movement: movement) }
  let!(:attendee) { FactoryGirl.create(:attendee, event: event) }

  describe "POST #mail_movement" do
    it "tells usermailer to mail" do
      post :mail_attendees, movement_id: movement.id, message: "TestMessage"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_event" do
    it "tells usermailer to mail_event" do
      post :mail_attendees, event_id: event, message: "Test Message"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end 
end
