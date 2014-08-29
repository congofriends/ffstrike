require 'spec_helper'

describe ContactController do
  let!(:coordinator){FactoryGirl.create(:user)}
	let!(:movement){FactoryGirl.create(:movement)}
  let!(:ownership){FactoryGirl.create(:ownership, user: coordinator, movement: movement)}
  let!(:event){FactoryGirl.create(:event, movement_id: movement.id)}

  before :each do
  	@params = {}
  	@params[:message] = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", host_id: event.id}
  	@params_message = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", host_id: event.id}
  	@message = Message.new(@params_message)
  	@mail = ContactMailer.new_message(@message)
    request.env["HTTP_REFERER"] = "where_i_came_from"
  end

	describe "POST #mail_movement" do
    it "tells usermailer to mail" do
      pending
      post :create_event_msg, message: @params_message
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_event" do
    it "tells usermailer to mail_event" do
      pending
      @params_message[:host_id] = movement.id
      post :create_movement_msg, message: @params_message
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_coordinators" do
    it "tells usermailer to email all coordinators" do
      pending
      @params_message = {subject: "Subject", body: "Body", host_id: movement.id, sender_id: coordinator.id }
      post :create_coordinator_msg, message: @params_message
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

  describe "POST #mail_memberss" do
    it "tells usermailer to email all members" do
      pending
      @params_message = {subject: "Subject", body: "Body", host_id: movement.id, sender_id: coordinator.id }
      post :create_members_msg, message: @params_message
      assert !ActionMailer::Base.deliveries.empty?
    end
  end

end
