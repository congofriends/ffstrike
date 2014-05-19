class ContactMailer < ActionMailer::Base
  default :from => "attendee@events.com"
  default :to => "host@events.com"

  def new_message(message)
  	@event = Event.find(message.event_id)
    @message = message
    mail(to: @event.host.email, from: @message.email, subject: "[#{@event.name}] #{message.subject}")
  end

end

