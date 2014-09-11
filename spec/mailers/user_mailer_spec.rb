require "spec_helper"

describe UserMailer do

  let!(:user_attendee) { FactoryGirl.create(:user, email: "bob@bob.com") }
  let!(:movement) { FactoryGirl.create(:movement) }
  let!(:ownership) { FactoryGirl.create(:ownership, movement: movement, user: user_attendee) }
  let!(:another_user) { FactoryGirl.create(:user, email: "another_user@example.com") }
  let(:event) { FactoryGirl.create(:event, movement: movement, host: user_attendee) }
  let(:task) { FactoryGirl.create(:task, event: event) }
  let(:another_event) { FactoryGirl.create(:event, host: another_user, movement: movement) }
  let!(:attendance) { FactoryGirl.create(:attendance, event: event, user: user_attendee) }

  describe "#task_signup_message" do

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

      let(:mail) { UserMailer.custom_attendees_message("Test Email Message", "Subject", movement) }

      it "renders the email" do
        mail.subject.should eq("Subject")
        mail.to.should eq([movement.users.first.email])
        mail.from.should eq([movement.users.first.email])
        mail.body.encoded.should match("Test Email Message")
      end

      it "mails attendees across events" do
        another_user_attendee = FactoryGirl.create :user, email: "testallattendees@example.com"
        FactoryGirl.create(:attendance, event: another_event, user: another_user_attendee)
        mail.bcc.should include(user_attendee.email)
      end

# add movement model method to return all attendees associated with movement
      it "doesnt mail other movements" do
        different_movement_event = FactoryGirl.create :event, host: another_user
        different_movement_attendee = FactoryGirl.create :user, email: "AnotherMovement@example.com"
        FactoryGirl.create(:attendance, event: different_movement_event, user: different_movement_attendee)

        mail.bcc.should_not include("AnotherMovement@example.com")
      end
    end

    context "event" do

      let(:mail) { UserMailer.custom_attendees_message("Test custom_message_event", "Subject", movement) }
      let(:another_user_attendee) { FactoryGirl.create :user, email: "testallmultipleattendees@example.com" }

      before do
        FactoryGirl.create(:attendance, event: event, user: another_user_attendee)
      end

      it "mails multiple attendees in event" do
        mail.bcc.should include("testallmultipleattendees@example.com")
      end

      it "doesn't mail attendee in other event" do
        other_user_attendee = FactoryGirl.create :user, email: "OtherEvent@example.com"
        FactoryGirl.create(:attendance, event: another_event, user: other_user_attendee)
        mail.bcc.should_not include("OtherEvent@example.com")
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

    let(:mail) { UserMailer.delete_event_message(event.id) }

    it "sends to attendees" do
      mail.to.should eq [event.host.email]
    end
    it "has correct body" do
      mail.body.encoded.should include "We're sorry, "
      mail.body.encoded.should include event.name
      mail.body.encoded.should include " has been canceled!"
    end
    it "has correct subject" do
      mail.subject.should eq "#{event.name} has been canceled."
    end
  end

  describe "#survey_event_message" do

    let(:mail) { UserMailer.survey_message(user_attendee.id, event.id) }

    it "sends to attendees" do
      mail.to.should eq [user_attendee.email]
    end
    it "has correct body" do
      mail.body.encoded.should include "Thanks for attending:"
      mail.body.encoded.should include event.name
    end
    it "has correct subject" do
      mail.subject.should eq "Thanks for attending: #{event.name}"
    end
  end

  describe "#delete_movement_message" do

    let(:mail) { UserMailer.delete_movement_message(movement.id) }

    it "sends to attendees" do
      mail.to.should include user_attendee.email
    end
    it "has correct body" do
      mail.body.encoded.should include "We're sorry, "
      mail.body.encoded.should include movement.name
      mail.body.encoded.should include " has been removed!"
    end
    it "has correct subject" do
      mail.subject.should eq "#{movement.name} has been removed."
    end
  end
end
