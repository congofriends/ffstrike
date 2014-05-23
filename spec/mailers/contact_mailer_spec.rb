require "spec_helper"

describe ContactMailer do
	let!(:movement){FactoryGirl.create(:movement)}
  let!(:event){FactoryGirl.create(:event, movement_id: movement.id)}

  before :each do
  	@params_message = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", event_id: event.id}
  	@message = Message.new(@params_message)
  	@mail = ContactMailer.new_message(@message)
  end

  it "renders the header" do
    @mail.subject.should eq(@message.subject)
    @mail.to.should eq([event.host.email])
    @mail.from.should eq([@message.email])
  end

  it "renders the body" do
    @mail.body.should include(@message.body)
  end
end
