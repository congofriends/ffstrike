class ContactController < ApplicationController

  def new_event_msg
    @event = Event.find_by_param(params[:id])
    @message = Message.new
  end

  def create_event_msg
    @message = Message.new(params[:message])
    @event =  Event.find @message.host_id

    if @message.valid?
      ContactMailer.new_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    end
  end

  def new_movement_msg
    @movement = Movement.find_by_param(params[:id])
    @message = Message.new
  end

  def create_movement_msg
    @message = Message.new(params[:message])
    @movement =  Movement.find @message.host_id

    if @message.valid?
      ContactMailer.new_mvmt_message(@message).deliver
      redirect_to(root_path, :notice => "Message was successfully sent.")
    end
  end

end
