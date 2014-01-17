require 'spec_helper'

describe MailController do

  before :each do
    @movement = FactoryGirl.create(:movement)
    @event = FactoryGirl.create(:event)
    @attendee = FactoryGirl.create(:attendee, movement_id: @movement.id, event_id: @event.id)
  end

  describe "POST #mail" do
    it "tells usermailer to mail" do
      post :mail_movement, movement_id: @movement, message: "TestMessage"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_event" do
    it "tells usermailer to mail_event" do
      post "mail_event", event_id: @event, movement_id: @event, message: "Test Message"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end 
end
