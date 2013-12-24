class UserMailer < ActionMailer::Base
  default from: "coordinator@rallies.com"

  def custom_message_all_attendees(movement_id, message)
    @recipients = Attendee.all.where(movement_id: movement_id) 
    @message = message
    unless @recipients.empty?
      mail(to: @recipients.collect(&:email).join(","))
      return true
    end
    return false
  end
end
