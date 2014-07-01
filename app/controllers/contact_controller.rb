class ContactController < ApplicationController
  # before_filter :load_message

  def new_event_msg
    @message = Message.new
    @event = Event.find_by_param(params[:id])
  end

  def create_event_msg
    load_message
    @event =  Event.find @message.host_id

    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    end
  end

  def new_movement_msg
    @message = Message.new
    @movement = Movement.find_by_param(params[:id])
  end

  def create_movement_msg
    load_message
    @movement = Movement.find @message.host_id

    if @message.valid?
      ContactMailer.new_mvmt_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    end
  end

  private

  def load_message
    @message ||=
      if params[:message]
        Message.new(params[:message])
      else
        Message.new
      end
  end

end
