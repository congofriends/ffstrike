class MailController < ApplicationController

  def mail_all
    id = mail_params[:movement_id]
    message = mail_params[:message]
    UserMailer.custom_message_all_attendees(id, message).deliver
    redirect_to movement_url(id)
  end

  def mail_params
    params.require(:mail).permit(:movement_id, :message)
  end

end
