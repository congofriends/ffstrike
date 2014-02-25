class MailController < ApplicationController
  before_filter :load_movement, :only => [:mail_movement] 
  before_filter :load_event, :only => [:mail_event]

  def mail_movement
    message = params[:message]
    if UserMailer.successfully_deliver?(@movement, message)
      flash[:notice] = "Sending Emails!"
    else 
      flash[:notice] = "You have no followers to email!"
    end
    redirect_to movement_url(params[:movement_id])
  end

  def mail_event
    message = params[:message]
    if UserMailer.successfully_deliver?(@event, message)
      flash[:notice] = "Sending Emails!"
    else
      flash[:notice] = "You have no attendees to email."
    end
    redirect_to movement_url(params[:movement_id])
  end

  private
  def load_movement
    @movement = Movement.find(params[:movement_id])
  end

  def load_event
    @event = Event.find(params[:event_id])
  end
end
