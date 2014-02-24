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
        expect(response).to redirect_to event_path(event)
      end

      it "notifies attendee that they signed up" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        flash[:notice].should == "Thanks for signing up!"
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
        expect(response).to redirect_to new_event_attendee_path(event)
      end

      it "notifies user that attendee information is missing required email field" do
        post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee_without_email)
        flash[:notice].should == "Email is required"
      end
    end

    context "host notification" do
      
      user = FactoryGirl.create(:user)
      event = FactoryGirl.create(:event)
      event.host = user
    
      context "with fewer than 10 attendees" do
        it "doesn't call attendee_mailer" do
          expect(UserMailer).not_to receive(:notify_host_of_event_size)
          attendees = FactoryGirl.create_list(:attendee, 8, event: event)
          post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        end
      end

      context "with 10 attendees" do
        it "calls UserMailer" do
          expect(UserMailer).to receive(:notify_host_of_event_size).with(event)
          attendees = FactoryGirl.create_list(:attendee, 9, event: event)
          post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        end
      end
    
      context "with 50 attendees" do
        it "calls UserMailer" do
          expect(UserMailer).to receive(:notify_host_of_event_size).with(event)
          attendees = FactoryGirl.create_list(:attendee, 49, event: event)
          post :create, event_id: event, attendee: FactoryGirl.attributes_for(:attendee)
        end 
      end
    end
  end
end
