require 'spec_helper'

describe AttendeesController do
  let(:movement) { FactoryGirl.create(:movement) }
  let(:rally) { FactoryGirl.create(:rally, movement: movement) }
  let(:attendee) { FactoryGirl.create(:attendee, rally: rally) }

  describe "POST #create" do
    context "with valid information" do
      it "creates an attendee" do
        expect{post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee)}.to change(Attendee, :count).by(1)
      end

      it "redirects to the rally show page" do
        post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee)
        expect(response).to redirect_to movement_rally_path(movement, rally)
      end

      it "notifies the user that task was created" do
        post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee)
        flash[:notice].should == "You sign up for the rally"
      end
    end

    context "with invalid information" do
      it "does not save the attendee" do
        expect{post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee_without_email)}.not_to change(Attendee, :count)
      end

      it "re-renders the same page" do
        post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee_without_email)
        expect(response).to redirect_to movement_path(movement, anchor: "rallies")
      end

      it "notifies user that attendee information is missing required email field" do
        post :create, rally_id: rally, attendee: FactoryGirl.attributes_for(:attendee_without_email)
        flash[:notice].should == "Email is required"
      end
    end
  end
end
