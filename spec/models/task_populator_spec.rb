require 'spec_helper'

describe TaskPopulator do

  it "assigns tasks to a speakout" do
    speakout = FactoryGirl.build(:event, event_type: "Speak Out")
    TaskPopulator.assign_tasks(speakout)
    expect(speakout.tasks).not_to be_empty
  end

  it "does not assign tasks to a custom event" do
    popcorn_eating_contest = FactoryGirl.build(:event, event_type: "Popcorn Eating Contest")
    TaskPopulator.assign_tasks(popcorn_eating_contest)
    expect(popcorn_eating_contest.tasks).to be_empty
  end

end
