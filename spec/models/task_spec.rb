require 'spec_helper'

describe Task do
  let(:event) { FactoryGirl.build(:event) }
  let(:task)  { event.tasks.build(description: "Lorem ipsum is a good task name") }

  subject { task }
  it {should respond_to(:description)}
  it {should respond_to(:event_id)}
  it {should respond_to(:event)}
  it {should respond_to(:assignments)}
  it {should respond_to(:assigned_attendees)}
  it {should respond_to(:assigned?)}
  it {should respond_to(:assign!)}

  #TODO: find out why this test is failing
  # its(:movement) {should eq movement}

  it "is not valid without a description" do
    expect(FactoryGirl.build(:task_without_description)).to_not be_valid
  end

  it "is not valid with a description longer than 250 symbols" do
    expect(FactoryGirl.build(:task_with_description_longer_than_250_characters)).to_not be_valid
  end

  it "is valid with a description 250 symbols" do
    expect(FactoryGirl.build(:task_with_description_250_characters)).to be_valid
  end

  describe "when event_id is not present" do
    before { task.event_id = nil }
    it {should_not be_valid}
  end

  describe "assigned?" do
    let(:event) { FactoryGirl.create(:event) }
    let(:attendee) { FactoryGirl.create(:attendee, event: event)  }
    let(:task) { FactoryGirl.create(:task, event: event) }
    before { task.assign!(attendee) }

    it {should be_assigned(attendee) }
    its(:assigned_attendees) { should include(attendee) }

   describe "and unassign" do
     before { task.unassign! (attendee) }
     
     it { should_not be_assigned(attendee) }
     its(:assigned_attendees) { should_not include(attendee) }
   end
  end
end
