require 'spec_helper'

describe Assignment do
  let(:attendee) { FactoryGirl.create(:attendee) }
  let(:task) { FactoryGirl.create(:task) }
  let(:assignment) { attendee.assignments.build(task_id: task.id) }
  
  subject { assignment }
  
  it { should be_valid }

  describe "attendee methods" do
    it { should respond_to(:attendee) }
    it { should respond_to(:task) }
  end

  describe "when attendee id is not present" do
    before { assignment.attendee_id = nil }
    it { should_not be_valid }
  end

  describe "when task id is not present" do
    before { assignment.task_id = nil }
    it { should_not be_valid }
  end
end
