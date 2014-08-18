require "spec_helper"

describe ContactMailer do
  let!(:movement){FactoryGirl.create(:movement)}
  let!(:coordinator){FactoryGirl.create(:user)}
  let!(:ownership){FactoryGirl.create(:ownership, user: coordinator, movement: movement)}

  describe "attendee_emails" do
    let!(:event){FactoryGirl.create(:event, movement_id: movement.id)}

    before :each do
      @params_message = {name: "attendee 1", email: "attendee@email.com", subject: "Subject", body: "Body", host_id: event.id}
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

  describe "emails_to_coordinators" do

    before :each do
      @params_message = {subject: "Subject", body: "Body", host_id: movement.id, sender_id: coordinator.id}
      @message = Message.new(@params_message)
      @mail = ContactMailer.new_coordinators_message(@message)
    end

    it "renders the header" do
      @coordinator_emails = []
      movement.ownerships.each { |ownership| @coordinator_emails << ownership.user.email if ownership.user.email}
      @sender = User.find(@message.sender_id)
      @mail.subject.should eq(@message.subject)
      @mail.to.should eq(@coordinator_emails)
      @mail.from.should eq([@sender.email])
    end

    it "renders the body" do
      @mail.body.should include(@message.body)
    end

  end

  describe "emails_to_members" do
    before :each do
      @params_message = {subject: "Subject", body: "Body", host_id: movement.id, sender_id: coordinator.id}
      @message = Message.new(@params_message)
      @mail = ContactMailer.new_members_message(@message)
    end

    it "renders the header" do
      @members_emails = []
      movement.memberships.each { |membership| @members_emails << membership.user.email if membership.user.email}
      @sender = User.find(@message.sender_id)
      @mail.subject.should eq(@message.subject)
      @mail.to.should eq(@members_emails)
      @mail.from.should eq([@sender.email])
    end

    it "renders the body" do
      @mail.body.should include(@message.body)
    end
  end
end
