require 'spec_helper'

describe Attendee do
 let(:rally)  { FactoryGirl.build(:rally) }
 before { @attendee = rally.attendees.build(email: "ant_farm@example.com") }

 subject { @attendee }
 it {should respond_to(:name) }
 it {should respond_to(:email)}
 it {should respond_to(:rally_id)}
 it {should respond_to(:rally)}

 #TODO: why does it fail?
 # it "is not valid without an email" do
 #   expect(FactoryGirl.build(:attendee_without_email)).to_not be_valid
 # end
 
 describe "when rally_id is not present" do
   before { @attendee.rally_id = nil }
   it {should_not be_valid}
 end
end
