class MailController < ApplicationController

  def mail_attendees
    if params[:event_id]
      @event = Event.find_by_param params[:event_id]
      send_mail(@event)
      redirect_to event_path(@event)
    else
      @movement = Movement.find_by_param params[:movement_id]
      send_mail(@movement)
      redirect_to dashboard_movement_path(@movement)
    end
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
end
