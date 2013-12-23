require 'spec_helper'

describe MailController do
  describe "POST #update" do
    before :each do
      attendee = FactoryGirl.create(:attendee, movement_id: "1")
    end

    #it "redirects to the movement dashboard" do
    #  expect(response).to redirect_to movement_path("1")
    #  post "mail_all", mail: {movement_id: "1", message: "TestMessage"}
    #end

    it "tells usermailer to mail" do
      post "mail_all", mail: {movement_id: "1", message: "TestMessage"}
      assert !ActionMailer::Base.deliveries.empty?
    end

  end
end
