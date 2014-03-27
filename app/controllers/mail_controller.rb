class MailController < ApplicationController

  def mail_attendees
    @scope = find_scope params
    send_mail @scope
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def send_mail(action)
    message = params[:message]
    if UserMailer.successfully_deliver?(action, message)
      flash[:notice] = t('mail.sent')
    else
      flash[:notice] = t('mail.no_attendees')
    end
  end

  def find_scope data
    if data[:event_id]
      Event.find_by_param data[:event_id]
    else
      Movement.find_by_param data[:movement_id]
    end
  end
end
