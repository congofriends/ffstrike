class ContactMailer < ActionMailer::Base
  # self.queue = MailerQueue.new
  # may not work because passing in message object
  default :from => "attendee@congoevents.org"
  default :to => "host@congoevents.org"

  def new_message(message)
  	@event = Event.find(message.host_id)
    @message = message
    mail(to: @event.host.email, from: @message.email, subject: @message.subject)
  end

  def new_attendee_message(message)
    @event = Event.find(message.host_id)
    @message = message
    @attendees = []
    @event.attendances.each{ |a| @attendees << a.user.email if a.user.email }
    mail(to: @event.host.email, bcc: @attendees, from: @event.host.email, subject: @message.subject)
  end

  def new_mvmt_message(message)
  	@movement = Movement.find(message.host_id)
    @message = message
    mail(to: @movement.users.first.email, from: @message.email, subject: @message.subject)
  end

end

