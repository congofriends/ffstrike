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

  def notify_coordinator_of_event_size(event)
    @event = event.name
    @event_size = event.number_of_attendees.to_s
    @coordinator = event.movement.user
    mail(to: @coordinator.email, from: "MovementApp@Events.com") 
  end

end
