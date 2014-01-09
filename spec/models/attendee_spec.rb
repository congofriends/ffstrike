require 'spec_helper'

describe Attendee do
 let(:rally)  { FactoryGirl.build(:rally) }
 let(:attendee) { rally.attendees.build(email: "ant_farm@com.com" ) }

 subject { attendee }
 it {should respond_to(:name) }
 it {should respond_to(:email)}
 it {should respond_to(:rally_id)}
 it {should respond_to(:rally)}
 it {should respond_to(:assignments)}
 it {should respond_to(:assigned_tasks)}
 it {should respond_to(:assigned?)}
 it {should respond_to(:assign!)}

 #TODO: why does it fail?
 # it "is not valid without an email" do
 #   expect(FactoryGirl.build(:attendee_without_email)).to_not be_valid
 # end
 
 describe "when rally_id is not present" do
   before { attendee.rally_id = nil }
   it {should_not be_valid}
 end

 describe "assigned?" do
   let(:rally) { FactoryGirl.create(:rally) }
   let(:attendee) { FactoryGirl.create(:attendee, rally: rally) }
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
