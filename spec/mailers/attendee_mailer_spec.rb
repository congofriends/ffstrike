require "spec_helper"

describe AttendeeMailer do

  let(:movement){FactoryGirl.create(:movement)}
  let(:event){FactoryGirl.create(:event, movement_id: movement.id)}
  let(:attendee){FactoryGirl.create(:attendee)}
  let(:mail){AttendeeMailer.signup_message(movement, event, attendee)}

  it "renders the header" do
    mail.subject.should eq("You've signed up to attend an event!")
    mail.to.should eq([attendee.email])
    mail.from.should eq(["coordinator@events.com"])
  end

  it "renders the body" do
    mail.body.should match("Thank you for signing up for an event with")
    mail.body.should match(movement.name)
    mail.body.should match("Your event details are below")
    mail.body.should match(event.name)
    mail.body.should match(event.address)
    mail.body.should match(event.city)
    mail.body.should match(event.zip)
    mail.body.should include(event.date)
    mail.body.should include(event.start_time)
    mail.body.should include(event.end_time)
  end
end
