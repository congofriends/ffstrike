class MailController < ApplicationController

  def mail_attendees
    @scope = find_scope params
    send_attendees_mail @scope
    message = params[:message]
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
    subject = params[:subject]
    if action.attendees.empty?
      flash[:notice] = t('mail.no_attendees')
    else

      CustomAttendeesMailWorker.perform_async(message, subject, action) if ENV["RAILS_ENV"] == "production"
      flash[:success] = t('mail.sent')
    end
  end

  def send_hosts_mail(action)
    message = params[:message]
    subject = params[:subject]
    if action.events.empty?
      flash[:notice] = t('mail.no_hosts')
    else
      CustomHostsMailWorker.perform_async(message, subject, action) if ENV["RAILS_ENV"] == "production"
      flash[:success] = t('mail.sent')
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
