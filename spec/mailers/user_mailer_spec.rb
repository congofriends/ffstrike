require "spec_helper"

describe UserMailer do
  describe "custom_message_all_attendees" do

    let(:mail) { UserMailer.custom_message_all_attendees(@movement, "Test Email Message") }
    let(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
    let(:another_rally) { FactoryGirl.create(:rally, coordinator: another_user) }

    before :each do
      @movement = FactoryGirl.create(:movement) 
      @user = FactoryGirl.create(:user, movement_id: @movement.id)
      @rally = FactoryGirl.create(:rally, movement_id: @movement.id, coordinator: @user)
      @attendee = FactoryGirl.create(:attendee, movement_id: @movement.id, rally: @rally)
    end
                                
    it "renders the headers" do
      mail.subject.should eq("Message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@rallies.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Test Email Message")
    end

    it "mails multiple attendees" do
      another_attendee = FactoryGirl.create :attendee, email: "TestAllAttendees@example.com", movement_id: @movement.id, rally: another_rally
      mail.to.should include("TestAllAttendees@example.com")
    end

    it "doesnt mail other movements" do 
      different_movement_attendee = FactoryGirl.create :attendee, email: "AnotherMovement@example.com", movement_id: @movement.id + 1, rally: another_rally
      mail.to.should_not include("AnotherMovement@example.com")
    end

  end

  describe "custom_message_rally" do

    let(:mail) { UserMailer.custom_message_rally(@rally, "Test custom_message_rally") }
    let(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
    let(:another_rally) { FactoryGirl.create(:rally, coordinator: another_user) }

    before :each do
      @movement = FactoryGirl.create(:movement) 
      @user = FactoryGirl.create(:user, movement_id: @movement.id)
      @rally = FactoryGirl.create(:rally, movement_id: @movement.id, coordinator: @user)
      @attendee = FactoryGirl.create(:attendee, movement_id: @movement.id, rally: @rally)
    end
     
    it "renders the headers" do
      mail.subject.should eq("Message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@rallies.com"])
    end
    it "renders the body" do
      mail.body.encoded.should match("Test custom_message_rally")
    end
    it "mails multiple attendees in rally" do
      another_attendee = FactoryGirl.create :attendee, email: "TestMultipleAttendees@example.com", movement_id: @movement.id, rally: @rally
      mail.to.should include("TestMultipleAttendees@example.com")
    end
    it "doesn't mail attendee in other rally" do
      other_rally_attendee = FactoryGirl.create :attendee, email: "OtherRally@example.com", movement_id: @movement.id, rally: another_rally
      mail.to.should_not include("OtherRally@example.com")
    end

  end

end
