class UsersMailer < ActionMailer::Base
  default from: "coordinator@rallies.com"

  def custom_message_all_attendees(movement, message)
    @recipients = Attendee.all.where(movement_id: movement.id) 
    @message = message
    mail(:to => @recipients.collect(&:email).join(","))
  end
end
