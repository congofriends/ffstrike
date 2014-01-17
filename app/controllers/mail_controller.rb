class MailController < ApplicationController

  def mail_movement
    movement = Movement.find(params[:movement_id])
    message = params[:message]
    if UserMailer.custom_message_movement(movement, message).deliver
      flash[:notice] = "Sending Emails!"
    else 
      flash[:notice] = "You have no followers to email!"
    end
    redirect_to movement_url(params[:movement_id])
  end

  def mail_event
    event = Event.find(params[:event_id])
    message = params[:message]
    if UserMailer.custom_message_event(event, message).deliver
      flash[:notice] = "Sending Emails!"
    else
      flash[:notice] = "You have no attendees to email."
    end
    redirect_to movement_url(params[:movement_id])
  end

end
