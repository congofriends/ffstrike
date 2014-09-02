class ContactMailer < ActionMailer::Base
  # self.queue = MailerQueue.new
  # may not work because passing in message object
  default :from => "attendee@congoevents.org"
  default :to => "host@congoevents.org"

  def new_message(message)
  	@event = Event.find(message.host_id)
    @message = message
    mail(to: @event.host.email, from: @message.email, subject: @message.subject).deliver
  end

  def new_attendee_message(message)
    @event = Event.find(message.host_id)
    @message = message
    @attendees = []
    @event.attendances.each{ |a| @attendees << a.user.email if a.user.email }
    mail(to: @event.host.email, bcc: @attendees, from: @event.host.email, subject: @message.subject).deliver
  end

  def new_coordinators_message(message)
    @group = Movement.find(message.host_id)
    @sender = User.find(message.sender_id)
    @message = message
    @coordinator_emails = []
    @group.ownerships.each { |ownership| @coordinator_emails << ownership.user.email if ownership.user.email}
    mail(to: @coordinator_emails, from: @sender.email, subject: @message.subject).deliver
  end

  def new_members_message(message)
    @group = Movement.find(message.host_id)
    @sender = User.find(message.sender_id)
    @message = message
    @members_emails = []
    @group.memberships.each { |membership| @members_emails << membership.user.email if membership.user.email}
    mail(to: @members_emails, from: @sender.email, subject: @message.subject).deliver
  end


  def new_mvmt_message(message)
  	@movement = Movement.find(message.host_id)
    @message = message
    mail(to: @movement.users.first.email, from: @message.email, subject: @message.subject).deliver
  end

end

