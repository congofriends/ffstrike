require 'spec_helper'

describe Task do
  let(:event) { FactoryGirl.create(:event) }
  let(:task)  { event.tasks.build(description: "Lorem ipsum is a good task name") }

  subject { task }
  it {should respond_to(:description)}
  it {should respond_to(:event_id)}
  it {should respond_to(:event)}
  it {should respond_to(:assignments)}
  it {should respond_to(:assign!)}

  its(:event) {should eq event}

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

  describe "assigned!" do
    let(:event) { FactoryGirl.create(:event) }
    let(:user) { FactoryGirl.create(:user)}
    let!(:attendance) { FactoryGirl.create(:attendance, event: event, user: user)  }
    let(:task) { FactoryGirl.create(:task, event: event) }

    it 'should create an assignment with task and attendance ids' do
      expect{task.assign!(user)}.to change(Assignment, :count).by(1)
      Assignment.last.task_id.should eq(task.id)
      Assignment.last.attendance_id.should eq(attendance.id)
    end
  end
end
