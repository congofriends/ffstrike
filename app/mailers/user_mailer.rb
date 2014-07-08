class UserMailer < ActionMailer::Base
  # self.queue = MailerQueue.new
  default from: "coordinator@events.com"

  def delete_event_message(event_id, attendee_email)
    @event = Event.find event_id

    mail(to: attendee_email, subject: "Your event has been canceled.").deliver
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

  def welcome(user_id, password, event_id)
    @password = password
    @recipient = User.find user_id
    @event = Event.find event_id

    mail(to: @recipient.email, subject: "Thanks for participating in the event").deliver
  end

# not being used?
  # def notify_host_of_event_size(event_id)
  #   @event = Event.find event_id
  #   @event_size = @event.number_of_attendees.to_s
  #   @host = @event.host

  #   mail(to: @host.email, from: "MovementApp@Events.com")
  # end
end

