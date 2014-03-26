class MailController < ApplicationController

  def mail_attendees
    if params[:movement_id]
      @movement = Movement.find_by_param params[:movement_id]
      send_mail(@movement)
    else
      @event = Event.find_by_param params[:event_id]
      send_mail(@event)
    end

    @movement ||= @event.movement
    redirect_to movement_url(@movement)
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
