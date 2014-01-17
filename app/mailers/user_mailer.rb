class UserMailer < ActionMailer::Base
  default from: "coordinator@events.com"

  def custom_message_movement(movement, message)
    @recipients = movement.attendees
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","))
      return true
    end
    return false
  end

  def custom_message_event(event, message)
    @recipients = event.attendees
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","))
      return true
    end
    return false
  end

end
