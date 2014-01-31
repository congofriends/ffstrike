require 'spec_helper'

describe Attendee do
 let(:event)  { FactoryGirl.build(:event) }
 let(:attendee) { event.attendees.build(email: "ant_farm@com.com" ) }

 subject { attendee }
 it {should respond_to(:name) }
 it {should respond_to(:email)}
 it {should respond_to(:event_id)}
 it {should respond_to(:event)}
 it {should respond_to(:assignments)}
 it {should respond_to(:assigned_tasks)}
 it {should respond_to(:assigned?)}
 it {should respond_to(:assign!)}

  it "is not valid without an email" do
    expect(FactoryGirl.build(:attendee_without_email)).not_to be_valid
  end
 
 describe "when event_id is not present" do
   before { attendee.event_id = nil }
   it {should_not be_valid}
 end

 describe "assigned?" do
   let(:event) { FactoryGirl.create(:event) }
   let(:attendee) { FactoryGirl.create(:attendee, event: event) }
   let(:task) { FactoryGirl.create(:task) }

   before { attendee.assign!(task) }

   it { should be_assigned(task) }
   its(:assigned_tasks) { should include(task) }

   describe "and unassign" do
     before { attendee.unassign!(task) }
     
     it { should_not be_assigned(task) }
     its(:assigned_tasks) { should_not include(task) }
   end
 end

end
