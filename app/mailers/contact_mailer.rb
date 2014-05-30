class ContactMailer < ActionMailer::Base
  default :from => "attendee@events.com"
  default :to => "host@events.com"

  def new_message(message)
  	@event = Event.find(message.host_id)
    @message = message
    mail(to: @event.host.email, from: @message.email, subject: @message.subject)
  end

  def new_mvmt_message(message)
  	@movement = Movement.find(message.host_id)
    @message = message
    mail(to: @movement.users.first.email, from: @message.email, subject: @message.subject)
  end

end

