require "spec_helper"

describe UserMailer do

  let!(:user_attendee) { FactoryGirl.create(:user) }
  let!(:movement) { FactoryGirl.create(:movement) }
  #let!(:ownership) { FactoryGirl.create(:ownership, movement: movement, user: user) }
  let!(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
  let(:event) { FactoryGirl.create(:event, movement: movement, host: user_attendee) }
  let(:task) { FactoryGirl.create(:task, event: event) }
  let(:another_event) { FactoryGirl.create(:event, host: another_user, movement: movement) }
  let!(:attendance) { FactoryGirl.create(:attendance, event: event, user: user_attendee) }

  describe "#dtask_signup_message" do

    let(:mail) { UserMailer.task_signup_message(event, task, user_attendee) }

    it "sends to attendees" do
      mail.to.should eq [user_attendee.email]
    end
    it "has correct body" do
      mail.body.encoded.should include "Welcome to Shift Engage."
      mail.body.encoded.should include event.name
    end
    it "has correct subject" do
      mail.subject.should eq "Thanks for Volunteering."
    end
  end

  describe "custom_message" do
    context "movement" do

      let(:mail) { UserMailer.custom_message("Test Email Message", user_attendee.email) }

      it "renders the email" do
        mail.subject.should eq("Message from your Movement Organizer")
        mail.to.should eq([user_attendee.email])
        mail.from.should eq(["coordinator@events.com"])
        mail.body.encoded.should match("Test Email Message")
      end

      it "mails attendees across events" do
        another_user_attendee = FactoryGirl.create :user, email: "testallattendees@example.com"
        FactoryGirl.create(:attendance, event: another_event, user: another_user_attendee)
        mail.to.should include(user_attendee.email)
      end

# add movement model method to return all attendees associated with movement
      it "doesnt mail other movements" do
        different_movement_event = FactoryGirl.create :event, host: another_user
        different_movement_attendee = FactoryGirl.create :user, email: "AnotherMovement@example.com"
        FactoryGirl.create(:attendance, event: different_movement_event, user: different_movement_attendee)

        mail.to.should_not include("AnotherMovement@example.com")
      end
    end

    context "event" do

      let(:mail) { UserMailer.custom_message("Test custom_message_event", another_user_attendee.email) }
      let(:another_user_attendee) { FactoryGirl.create :user, email: "testallmultipleattendees@example.com" }

      before do
        FactoryGirl.create(:attendance, event: event, user: another_user_attendee)
      end

      it "mails multiple attendees in event" do
        mail.to.should include("testallmultipleattendees@example.com")
      end

      it "doesn't mail attendee in other event" do
        other_user_attendee = FactoryGirl.create :user, email: "OtherEvent@example.com"
        FactoryGirl.create(:attendance, event: another_event, user: other_user_attendee)
        mail.to.should_not include("OtherEvent@example.com")
      end
    end
  end

  # describe "#notify_host_of_event_size" do

  #   let(:mail) { UserMailer.notify_host_of_event_size(event) }
  #   let!(:user_attendee1){ FactoryGirl.create :user, email: "testattendee01@example.com"}
  #   let!(:user_attendee2){ FactoryGirl.create :user, email: "testattendee02@example.com"}
  #   let!(:attendance1){FactoryGirl.create(:attendance, event: event, user: user_attendee1)}
  #   let!(:attendance2){FactoryGirl.create(:attendance, event: event, user: user_attendee2)}


  #   it "sends to coordinator" do
  #     mail.to.should eq([user_attendee.email])
  #   end

  #   it "has correct body" do
  #     mail.body.encoded.should include("has reached 3 attendees")
  #     mail.body.encoded.should include(event.name)
  #   end
  # end

  describe "#delete_event_message" do

    let(:mail) { UserMailer.delete_event_message(event, user_attendee.email) }

    it "sends to attendees" do
      mail.to.should eq [user_attendee.email]
    end
    it "has correct body" do
      mail.body.encoded.should include "We're sorry, your event,"
      mail.body.encoded.should include event.name
      mail.body.encoded.should include "has been canceled!"
    end
    it "has correct subject" do
      mail.subject.should eq "Your event has been canceled."
    end
  end
end
