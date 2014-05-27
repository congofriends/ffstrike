require 'spec_helper'

describe ContactController do
	let!(:movement){FactoryGirl.create(:movement)}
  let!(:event){FactoryGirl.create(:event, movement_id: movement.id)}

  before :each do
  	@params_message = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", event_id: event.id}
  	@message = Message.new(@params_message)
  	@mail = ContactMailer.new_message(@message)
  end

end
