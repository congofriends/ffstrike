class MailController < ApplicationController

  def mail_attendees
    if params[:movement_id]
      @movement = Movement.find(params[:movement_id])
      send_mail(@movement)
    else
      @event = Event.find(params[:event_id])
      send_mail(@event)
    end

    @movement ||= @event.movement
    redirect_to movement_url(@movement)
  end

  private

  def send_mail(action)
    message = params[:message]
    if UserMailer.successfully_deliver?(action, message)
      flash[:notice] = "Sending Emails!"
    else
      flash[:notice] = "You have no attendees to email."
    end
  end
end
