require 'spec_helper'

describe MailController do
  let!(:movement) { FactoryGirl.create(:movement) }
  let!(:event) { FactoryGirl.create(:event, movement: movement) }
  let!(:user_attendee1){ FactoryGirl.create :user}
  let!(:ownership) { FactoryGirl.create(:ownership, movement: movement, user: user_attendee1) }
  let!(:attendance1){FactoryGirl.create(:attendance, event: event, user: user_attendee1)}

  describe "POST #mail_movement" do
    it "tells usermailer to mail" do
      post :mail_attendees, movement_id: movement, message: "TestMessage"
      assert !ActionMailer::Base.deliveries.empty?
    end
  end
end
