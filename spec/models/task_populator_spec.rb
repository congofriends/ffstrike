require 'spec_helper'

describe TaskPopulator do

  it "assigns tasks to a speakout" do
    speakout_event = FactoryGirl.build(:event, event_type_id: 2)
    TaskPopulator.assign_tasks(speakout_event)
    expect(speakout_event.tasks).not_to be_empty
  end

end
