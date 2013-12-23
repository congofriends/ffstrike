require "spec_helper"

describe UsersMailer do
  describe "custom_message_all_attendees" do

    let(:mail) { UsersMailer.custom_message_all_attendees(@movement, "Test Email Message") }

    before :each do
      @movement = FactoryGirl.create(:movement) 
      @movement_resource = {movement_id: @movement.id}
      @attendee = FactoryGirl.create(:attendee, @movement_resource)
      @user = FactoryGirl.create(:user, @movement_resource)
    end
                                
    it "renders the headers" do
      mail.subject.should eq("Custom message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@rallies.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Test Email Message")
    end

    it "mails all attendees" do
      another_attendee = FactoryGirl.create :attendee, email: "TestAllAttendees@example.com", movement_id: @movement.id 
      mail.to.should include("TestAllAttendees@example.com")
    end

    it "doesnt mail other movements" do 
    end

  end

end
