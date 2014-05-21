require 'spec_helper'

describe AssignmentsController do
  let(:movement) { FactoryGirl.create(:movement) }
  let(:event) { FactoryGirl.create(:event, movement: movement) }
  let(:task) { FactoryGirl.create(:task, event: event) }
  let(:user) {FactoryGirl.create(:user)}
  let!(:attendance) {FactoryGirl.create(:attendance, user: user, event: event)}

  describe "Get #assign" do

    context "a user attending the event signs up" do
      before { @controller.stub(:current_user).and_return(user) }

      it "assigns task to attendee" do
        get "assign", id: task, event_id: event
        Assignment.last.attendance_id.should == attendance.id
      end
    end
  end
end
