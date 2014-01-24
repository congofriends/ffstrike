require 'spec_helper'

describe AttendeesController do
  let(:movement) { FactoryGirl.create(:movement) }
  let(:event) { FactoryGirl.create(:event, movement: movement) }
  let(:attendee) { FactoryGirl.create(:attendee, event: event) }

  describe "POST #create" do
    context "with valid information" do
      it "creates an attendee" do
        expect{post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)}.to change(Attendee, :count).by(1)
      end

      it "redirects to the event show page" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        expect(response).to redirect_to movement_event_path(movement, event)
      end

      it "notifies attendee that they signed up" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        flash[:notice].should == "You signed up for the event"
      end

      it "mails the attendee" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        assert !ActionMailer::Base.deliveries.empty?
      end

    end

    context "with invalid information" do
      it "does not save the attendee" do
        expect{post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee_without_email)}.not_to change(Attendee, :count)
      end

      it "re-renders the same page" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee_without_email)
        expect(response).to redirect_to movement_path(movement, anchor: "events")
      end

      it "notifies user that attendee information is missing required email field" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee_without_email)
        flash[:notice].should == "Email is required"
      end
    end
  end
end
