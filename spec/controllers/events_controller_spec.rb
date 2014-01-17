require 'spec_helper'

describe EventsController do
  describe "GET #new" do
    before :each do
      movement = FactoryGirl.create(:movement)
      get "new", movement_id: movement 
    end

    it "responds successfully" do
       expect(response).to be_success
    end

    it "creates new event" do
      expect(assigns(:event)).not_to be(nil)       
    end
  end

  describe "POST #create" do
    let(:movement){FactoryGirl.create(:movement)}
    let(:coordinator){FactoryGirl.create(:user)}

    context "with valid attributes" do
      it "creates a event" do
        expect{post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)}.to change(Event, :count).by(1)
      end

      it "creates a event connected to the movement" do
        post :create, movement_id: movement.id, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
        expect(Event.last.movement_id).to eq(movement.id)
      end

      it "redirects to the movement page" do
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
        expect(response).to redirect_to movement_path(movement, anchor: "events")
      end

      it "notifies the user that event was created" do
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
        flash[:notice].should == "Event created!"
      end
    end

    context "with invalid fields" do
      it "does not save the event" do
        expect{post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event)}.not_to change(Event, :count)
      end

      it "re-renders the new method" do
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:invalid_event)
        expect(response).to redirect_to movement_path(movement, anchor: "events")
      end

      it "notifies user that event had errors" do
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:invalid_event)
        flash[:notice].should == "Coordinator can't be blank Address can't be blank"
      end
    end 
  end

  describe "GET #search" do
    it "responds successfully" do
      get "search", zip: "60647"  
      expect(response).to be_success
    end

    it "assigns @events" do
      zip = FactoryGirl.create(:zipcode, zip: "60647", latitude: 10, longitude: 50)
      event = FactoryGirl.create(:event, zip: "60647") 
      get "search", zip: "60647"
      expect(assigns(:events)).to eq([event])
    end
  end
end

