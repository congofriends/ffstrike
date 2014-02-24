require "spec_helper"

describe UserMailer do

  let(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
  let(:another_event) { FactoryGirl.create(:event, host: another_user) }

  before :each do
    @movement = FactoryGirl.create(:movement) 
    @user = FactoryGirl.create(:user, movement_id: @movement.id)
    @event = FactoryGirl.create(:event, movement_id: @movement.id, host: @user)
    @attendee = FactoryGirl.create(:attendee, movement_id: @movement.id, event: @event)
  end
 
  describe "custom_message_all_attendees" do

    let(:mail) { UserMailer.custom_message_movement(@movement, "Test Email Message") }
                               
    it "renders the headers" do
      mail.subject.should eq("Message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@events.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Test Email Message")
    end

    it "mails multiple attendees" do
      another_attendee = FactoryGirl.create :attendee, email: "TestAllAttendees@example.com", movement_id: @movement.id, event: another_event
      mail.to.should include("TestAllAttendees@example.com")
    end

    it "doesnt mail other movements" do 
      different_movement_attendee = FactoryGirl.create :attendee, email: "AnotherMovement@example.com", movement_id: @movement.id + 1, event: another_event
      mail.to.should_not include("AnotherMovement@example.com")
    end

  end

  describe "custom_message_event" do

    let(:mail) { UserMailer.custom_message_event(@event, "Test custom_message_event") }
    
    it "renders the headers" do
      mail.subject.should eq("Message from your Movement Organizer")
      mail.to.should eq(["email@example.com"])
      mail.from.should eq(["coordinator@events.com"])
    end
    it "renders the body" do
      mail.body.encoded.should match("Test custom_message_event")
    end
    it "mails multiple attendees in event" do
      another_attendee = FactoryGirl.create :attendee, email: "TestMultipleAttendees@example.com", movement_id: @movement.id, event: @event
      mail.to.should include("TestMultipleAttendees@example.com")
    end
    it "doesn't mail attendee in other event" do
      other_event_attendee = FactoryGirl.create :attendee, email: "OtherEvent@example.com", movement_id: @movement.id, event: another_event
      mail.to.should_not include("OtherEvent@example.com")
    end

  end

  describe "#notify_host_of_event_size" do
 
    let!(:user) { FactoryGirl.create(:user) }
    let!(:event) { FactoryGirl.create(:event, host: user) }
    let!(:attendees) { FactoryGirl.create_list(:attendee, 3, event: event) }
    let(:mail) { UserMailer.notify_host_of_event_size(event) }

    it "sends to coordinator" do
      mail.to.should eq([user.email])
    end

    it "has correct body" do
      mail.body.encoded.should include("has reached 3 attendees")
      mail.body.encoded.should include(event.name)
    end
  end
end
