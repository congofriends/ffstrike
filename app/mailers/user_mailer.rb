class UserMailer < ActionMailer::Base
  default from: "coordinator@rallies.com"

  def custom_message_movement(movement, message)
    @recipients = movement.attendees
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","))
      return true
    end
    return false
  end

  def custom_message_rally(rally, message)
    @recipients = rally.attendees
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","))
      return true
    end
    return false
  end

end
