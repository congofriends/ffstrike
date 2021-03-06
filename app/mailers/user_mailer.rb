class UserMailer < ActionMailer::Base
  # self.queue = MailerQueue.new
  default from: "coordinator@congoevents.org"

  def delete_event_message(event_id)
    @event = Event.where(id: event_id).first
    return unless @event
    @attendee_emails = []
    @event.attendees.each { |attendee| @attendee_emails << attendee.email }
    mail(to: @event.host.email, bcc: @attendee_emails, subject: "#{@event.name} has been canceled.").deliver
  end

  def delete_movement_message(movement_id)
    @movement = Movement.where(id: movement_id).first
    return unless @movement
    @members_emails = []
    @movement.members.each { |member| @members_emails << member.email }
    mail(to: @members_emails, subject: "#{@movement.name} has been removed.").deliver
  end

  def task_signup_message(event_id, task_id, attendee_id)
    @event = Event.find event_id
    @task = Task.find task_id
    @attendee = User.find attendee_id
    mail(to: @attendee.email, subject: "Thanks for Volunteering.").deliver
  end

  def custom_attendees_message(message, subject, action)
    @message = message
    @attendee_emails = []
    action.attendees.each { |attendee| @attendee_emails << attendee.email }
    mail(to: action.users.first.email, from: action.users.first.email , bcc: @attendee_emails, subject: subject).deliver
  end

  def custom_hosts_message(message, subject, action)
    @message = message
    @event_hosts = []
    action.events.each { |event| @event_hosts << event.host.email unless @event_hosts.include? event.host.email }
    mail(to: action.users.first.email, from: action.users.first.email, bcc: @event_hosts, subject: subject).deliver
  end

  def welcome_message(user_id, password, event_id)
    @password = password
    @recipient = User.find user_id
    @event = Event.where(id: event_id).first
    return unless @event
    mail(to: @recipient.email, subject: "Thanks for participating in the event: #{@event.name}").deliver
  end

  def reminder_message(user_id, event_id)
    @recipient = User.find user_id
    @event = Event.where(id: event_id).first
    return unless @event
    mail(to: @recipient.email, subject: "#{@event.name} is coming up!").deliver unless Attendance.where(user_id: @recipient, event_id: @event).empty?
  end

  def team_creation_message(user_id, team_id)
    @recipient = User.find user_id
    @team = Movement.find team_id
    mail(to: @recipient.email, subject: "Team #{@team.name} Created Successfully").deliver
  end

  def event_creation_message(user_id, event_id)
    @recipient = User.find user_id
    @event = Event.find event_id
    mail(to: @recipient.email, subject: "Event #{@event.name} Created Successfully").deliver
  end

  def survey_message(user_id, event_id)
    @recipient = User.find user_id
    @event = Event.where(id: event_id).first
    return unless @event
    mail(to: @recipient.email, subject: "Thanks for attending: #{@event.name}").deliver unless Attendance.where(user_id: @recipient, event_id: @event).empty?
  end


# not being used?
  # def notify_host_of_event_size(event_id)
  #   @event = Event.find event_id
  #   @event_size = @event.number_of_attendees.to_s
  #   @host = @event.host

  #   mail(to: @host.email, from: "MovementApp@Events.com")
  # end
end

