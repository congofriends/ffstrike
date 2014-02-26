require "spec_helper"

describe UserMailer do

  let!(:user) { FactoryGirl.create(:user) }
  let(:movement) { FactoryGirl.create(:movement, user: user) }
  let!(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
  let(:event) { FactoryGirl.create(:event, movement: movement, host: user) }
  let(:another_event) { FactoryGirl.create(:event, host: another_user, movement: movement) }
  let!(:attendee) { FactoryGirl.create(:attendee, event: event) }

  describe "custom_message" do
    context "movement" do

      let(:mail) { UserMailer.custom_message(movement, "Test Email Message") }
                                 
      it "renders the email" do
        mail.subject.should eq("Message from your Movement Organizer")
        mail.to.should eq(["email@example.com"])
        mail.from.should eq(["coordinator@events.com"])
        mail.body.encoded.should match("Test Email Message")
      end

      it "mails attendees across events" do
        another_attendee = FactoryGirl.create :attendee, email: "TestAllAttendees@example.com", event: another_event
        mail.to.should include("TestAllAttendees@example.com")
        mail.to.should include("email@example.com")
      end

      it "doesnt mail other movements" do 
        different_movement_event = FactoryGirl.create :event, movement_id: movement.id + 1, host: another_user
        different_movement_attendee = FactoryGirl.create :attendee, email: "AnotherMovement@example.com", event: different_movement_event
        mail.to.should_not include("AnotherMovement@example.com")
      end
    end

    context "event" do

      let(:mail) { UserMailer.custom_message(event, "Test custom_message_event") }

      it "mails multiple attendees in event" do
        another_attendee = FactoryGirl.create :attendee, email: "TestMultipleAttendees@example.com", movement_id: movement.id, event: event
        mail.to.should include("TestMultipleAttendees@example.com")
      end

      it "doesn't mail attendee in other event" do
        other_event_attendee = FactoryGirl.create :attendee, email: "OtherEvent@example.com", movement_id: movement.id, event: another_event
        mail.to.should_not include("OtherEvent@example.com")
      end
    end
  end

  describe "#notify_host_of_event_size" do
 
    let(:mail) { UserMailer.notify_host_of_event_size(event) }
    let!(:attendees) { FactoryGirl.create_list(:attendee, 2, event: event) }

    it "sends to coordinator" do
      mail.to.should eq([user.email])
    end

    it "has correct body" do
      mail.body.encoded.should include("has reached 3 attendees")
      mail.body.encoded.should include(event.name)
    end
  end
end
