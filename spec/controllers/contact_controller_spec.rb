require 'spec_helper'

describe ContactController do
	let!(:movement){FactoryGirl.create(:movement)}
  let!(:event){FactoryGirl.create(:event, movement_id: movement.id)}

  before :each do
  	@params = {}
  	@params[:message] = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", host_id: event.id}
  	# @params_message = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", host_id: event.id}
  	# @message = Message.new(@params_message)
  	# @mail = ContactMailer.new_message(@message)
  end

	# describe "POST #mail_movement" do
 #    it "tells usermailer to mail" do
 #    	binding.pry
 #      post :create_event_msg, params: @params
 #      assert !ActionMailer::Base.deliveries.empty?
 #    end
  # end

  # describe "POST #mail_event" do
  #   it "tells usermailer to mail_event" do
  #     post :create_movement_msg, event_id: event, message: "Test Message"
  #     assert !ActionMailer::Base.deliveries.empty?
  #   end
  # end


end
