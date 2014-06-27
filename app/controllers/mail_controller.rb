class MailController < ApplicationController

  def mail_attendees
    @scope = find_scope params
    send_attendees_mail @scope
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  def mail_hosts
    @scope = find_scope params
    send_hosts_mail @scope
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to root_path
  end

  private

  def send_attendees_mail(action)
    message = params[:message]
    if action.attendees.empty?
      flash[:notice] = t('mail.no_attendees')
    else

      #todo: move to queue
      action.attendees.each do |attendee|
        UserMailer.custom_message(message, attendee.email)
      end

      flash[:notice] = t('mail.sent')
    end
  end

  def send_hosts_mail(action)
    message = params[:message]
    if action.events.empty?
      flash[:notice] = t('mail.no_hosts')
    else

      #todo: move to queue
      action.events.each do |event|
        UserMailer.custom_message(message, event.host.email)
      end

      flash[:notice] = t('mail.sent')
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
