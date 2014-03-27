require 'spec_helper'

describe AssignmentsController do
  let(:movement) { FactoryGirl.create(:movement) }
  let(:event) { FactoryGirl.create(:event, movement: movement) }
  let(:task) { FactoryGirl.create(:task) }

  describe "Get #assign" do

    context "a non-attendee signs up" do
      it "notifies the user that only attendess can sign up" do
        get "assign", id: task, event_id: event
        flash[:notice].should == "Tasks are for attendees only"
      end
    end
    
    context "a valid attendee signs up" do
      before { session[:current_attendee_id] = 7}

      it "notifies that attendee has signed up" do
        get "assign", id: task, event_id: event, session: session
        flash[:notice].should == "Thanks for signing up!"
      end

      it "assigns task to attendee" do
        get "assign", id: task, event_id: event, session: session
        Assignment.last.attendee_id.should == session[:current_attendee_id]
      end
    end
  end
end
