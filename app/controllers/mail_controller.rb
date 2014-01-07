class MailController < ApplicationController

  def mail_movement
    movement_id = params[:movement_id]
    message = params[:message]
    if UserMailer.custom_message_movement(movement_id, message).deliver
      flash[:notice] = "Sending Emails!"
    else 
      flash[:notice] = "You have no followers to email!"
    end
    redirect_to movement_url(movement_id)
  end

  def mail_rally
    rally_id = params[:rally_id]
    message = params[:message]
    if UserMailer.custom_message_rally(rally_id, message).deliver
      flash[:notice] = "Sending Emails!"
    else
      flash[:notice] = "You have no attendees to email."
    end
    redirect_to movement_url(params[:movement_id])
  end

end
