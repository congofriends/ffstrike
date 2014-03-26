class UserMailer < ActionMailer::Base
  default from: "coordinator@events.com"

  def delete_event_message(event)
    @recipients = event.attendees
    @event = event
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","), subject: "Your event has been canceled.").deliver
      return true
    end
    return false
  end

  def custom_message(action, message)
    @recipients = action.attendees
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","), subject: "Message from your Movement Organizer")
      return true
    end
    return false
  end
  
  def self.successfully_deliver?(action, message)
    custom_message(action, message).deliver
  end

  def notify_host_of_event_size(event)
    @event = event.name
    @event_size = event.number_of_attendees.to_s
    @host = event.host
    mail(to: @host.email, from: "MovementApp@Events.com") 
  end
end
