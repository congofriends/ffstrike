require 'spec_helper'

describe MailController do
  describe "POST #update" do
    before :each do
      attendee = FactoryGirl.create(:attendee, movement_id: "1")
    end

    it "tells usermailer to mail" do
      post "mail_all", mail: {movement_id: "1", message: "TestMessage"}
      assert !ActionMailer::Base.deliveries.empty?
    end

  end
end
