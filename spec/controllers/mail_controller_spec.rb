require 'spec_helper'

describe MailController do

  let!(:movement) { FactoryGirl.create(:movement) }
  let!(:event) { FactoryGirl.create(:event, movement: movement) }
  let!(:user_attendee1){ FactoryGirl.create :user}
  let!(:attendance1){FactoryGirl.create(:attendance, event: event, user: user_attendee1)}

  describe "POST #mail_movement" do
    it "tells usermailer to mail" do
      post :mail_attendees, movement_id: movement, message: "TestMessage"
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
