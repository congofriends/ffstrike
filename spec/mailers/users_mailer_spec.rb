require "spec_helper"

describe UsersMailer do
  describe "custom_message_all_attendees" do
    let(:mail) { UsersMailer.custom_message_all_attendees(@movement, "Test Email Message") }
    before :each do
      @user = FactoryGirl.create(:user)
      @attendee = FactoryGirl.create(:attendee)
      @movement = FactoryGirl.create(:movement) 
    end
                                
    it "renders the headers" do
      mail.subject.should eq("Custom message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@rallies.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Test Email Message")
    end
  end

end
