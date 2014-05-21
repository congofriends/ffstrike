require 'spec_helper'

describe Assignment do
  let(:attendance) { FactoryGirl.create(:attendance) }
  let(:task) { FactoryGirl.create(:task) }
  let(:assignment) { attendance.assignments.build(task_id: task.id) }

  subject { assignment }

  it { should be_valid }

  describe "attendance methods" do
    it { should respond_to(:attendance) }
    it { should respond_to(:task) }
  end

  describe "when attendance id is not present" do
    before { assignment.attendance_id = nil }
    it { should_not be_valid }
  end

  describe "when task id is not present" do
    before { assignment.task_id = nil }
    it { should_not be_valid }
  end
end
