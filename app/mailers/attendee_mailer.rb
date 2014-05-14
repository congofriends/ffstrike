class AttendeeMailer < ActionMailer::Base
  default from: "coordinator@events.com"

  def signup_message(movement, event, user)
    @movement = movement
    @event = event
    mail(to: user.email)
  end


end
