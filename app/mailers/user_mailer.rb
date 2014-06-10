class UserMailer < ActionMailer::Base
  default from: "coordinator@events.com"

  def delete_event_message(event, attendee_email)
    @event = event

    mail(to: attendee_email, subject: "Your event has been canceled.").deliver
  end

  def custom_message(message, attendee_email)
    @message = message

    mail(to: attendee_email, subject: "Message from your Movement Organizer").deliver
  end

  def welcome(user, password, event)
    @password = password
    @recipient = user
    @event = event

    mail(to: @recipient.email, subject: "Thanks for participating in the event").deliver
  end


  def notify_host_of_event_size(event)
    @event = event.name
    @event_size = event.number_of_attendees.to_s
    @host = event.host

    mail(to: @host.email, from: "MovementApp@Events.com")
  end
end
