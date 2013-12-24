class MailController < ApplicationController

  def mail_all
    id = mail_params['movement_id']
    message = mail_params['message']
    if UserMailer.custom_message_all_attendees(id, message)
      flash[:notice] = "Sending Emails!"
    else 
      flash[:notice] = "You have no followers to email!"
    end
    redirect_to movement_url(id)
  end

  def mail_params
    params.require(:mail).permit(:movement_id, :message)
  end

end
