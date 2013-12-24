class UsersMailer < ActionMailer::Base
  default from: "coordinator@rallies.com"

  def custom_message_all_attendees(movement, message)
    Attendee.all.where(movement_id: movement.id).each do |attendee|
      send_custom_message(attendee.email, message)
    end 
  end

  def send_custom_message(email, message)
    @message = message 
    mail to: email
  end

end
