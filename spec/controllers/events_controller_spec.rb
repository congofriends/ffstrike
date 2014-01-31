require 'spec_helper'

describe EventsController do

  let(:coordinator){FactoryGirl.create(:user)}
  let(:movement){FactoryGirl.create(:movement, user: coordinator)}

  describe "GET #explanation" do
    it "responds successfully" do
      sign_in coordinator
      event = FactoryGirl.create(:event, movement: movement)
      get :explanation, id: event
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    before :each do
      sign_in coordinator
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
    let(:visitor){FactoryGirl.create(:user)}

    context "with valid attributes" do
      it "creates a event" do
        expect{post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)}.to change(Event, :count).by(1)
      end

      it "calls the task prepopulator" do
        TaskPopulator.should_receive(:assign_tasks)
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
      end

      it "creates a event connected to the movement" do
        post :create, movement_id: movement.id, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
        expect(Event.last.movement_id).to eq(movement.id)
      end

      it "notifies the user that event was created" do
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
        flash[:notice].should == "Event created!"
      end
    
      context "as a coordinator" do
        it "redirects to the explanation page" do
          @controller.stub(:current_user).and_return(coordinator)
          post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
          expect(response).to redirect_to explanation_path(Event.last)
        end
      end

      context "as a visitor" do
        it "redirects to the visitor page" do
          post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event).merge(coordinator_id: coordinator.id)
          expect(response).to redirect_to visitor_path(movement)
        end
      end
    end

    context "with invalid fields" do
      it "does not save the event" do
        expect{post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event)}.not_to change(Event, :count)
      end

      it "re-renders the new method" do
        @controller.stub(:current_user).and_return(coordinator)
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:invalid_event).merge(coordinator_id: coordinator.id)
        expect(response).to redirect_to dashboard_movement_path(movement, anchor: "events")
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

  describe "PUT #update" do
    let(:event){FactoryGirl.create(:event, coordinator_id: coordinator.id)}

    it "changes attributes" do
      put :update, movement_id: movement, id: event, event: {notes: "attribute changed"}
      expect(Event.find(event.id).notes).to eql("attribute changed") 
    end

    it "redirects to movement page anchored in event" do
      put :update, movement_id: movement, id: event, event: FactoryGirl.attributes_for(:event) 
      expect(response).to redirect_to dashboard_movement_path(event.movement, anchor: "events")
    end

    it "notifies user that event was updated" do
      put :update, movement_id: movement, id: event, event: {notes: "attribute changed"}
      flash[:notice].should == "Event updated."
    end
  end

end

