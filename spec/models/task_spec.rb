require 'spec_helper'

describe Task do
  let(:rally) { FactoryGirl.build(:rally) }
  before do 
    @task = Task.new(description: "Lorem ipsum", rally_id: rally.id)
  end

  subject { @task }
  it {should respond_to(:description)}
  it {should respond_to(:rally_id)}


  it "is not valid without a description" do
    expect(FactoryGirl.build(:task_without_description)).to_not be_valid
  end

  it "is not valid with a description longer than 250 symbols" do
    expect(FactoryGirl.build(:task_with_description_longer_than_250_characters)).to_not be_valid
  end

  it "is valid with a description 250 symbols" do
    expect(FactoryGirl.build(:task_with_description_250_characters)).to be_valid
  end

  describe "when rally_id is not present" do
    before { @task.rally_id = nil }
    it {should_not be_valid}
  end
end
