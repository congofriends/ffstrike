class ContactController < ApplicationController
  def new
    @event = Event.find_by_param(params[:id])
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    @event =  Event.find @message.event_id
    redirect_to(root_path, :notice => "Message was successfully sent.") if @message.valid?

    # if @message.valid?
    #   ContactMailer.new_message(@message).deliver
    #   # redirect_to :back, notice: "Message was successfully sent."
    #   redirect_to(root_path, :notice => "Message was successfully sent.")
    # else
    #   flash.now.alert = "Please fill all fields."
    #   #render :new
    #   # redirect_to new_contact_path(@event)
    #   respond_to { |format| format.js }
    # end

    # respond_to do |format|
    #   if @message.valid?
    #     ContactMailer.new_message(@message).deliver
    #     format.js { render "valid",  notice: "Message was successfully sent." }
    #   else
    #     format.js { render "invalid", notice: "Please fill all fields in" }
    #   end
    # end
  end

end
