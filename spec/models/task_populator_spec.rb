require 'spec_helper'

describe TaskPopulator do

  it "assigns tasks to a speakout" do
    speakout_event = FactoryGirl.build(:event, event_type_id: 2 )
    TaskPopulator.assign_tasks(speakout_event)
    expect(speakout_event.tasks).not_to be_empty
  end

  it "does not assign tasks to a custom event" do
    own_type_event = FactoryGirl.build(:event, event_type_id: 6)
    TaskPopulator.assign_tasks(own_type_event)
    expect(own_type_event.tasks).to be_empty
  end

end
