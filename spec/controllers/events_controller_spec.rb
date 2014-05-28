require 'spec_helper'

describe EventsController do

  let(:coordinator){FactoryGirl.create(:user)}
  let(:movement){FactoryGirl.create(:movement)}
  let!(:ownership){FactoryGirl.create(:ownership, user: coordinator, movement: movement)}
  let(:event) {FactoryGirl.create(:event, movement: movement)}

  describe "GET #explanation" do
    it "responds successfully" do
      sign_in coordinator
      get :explanation, id: event
      expect(response).to be_success
    end
  end

  describe "DELETE #delete" do
    it "deletes the event" do
      sign_in coordinator
      delete :destroy, id: event
      expect { Event.all == [] }
    end
    it "emails attendees" do
      sign_in coordinator
      UserMailer.should_receive(:delete_event_message).with(event)
      delete :destroy, id: event
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

  describe "PUT #approve" do
    it "approves an unapproved event" do
      event = FactoryGirl.create(:event)
      put :approve, id: event
      event.reload
      expect(event.approved).to be_true
    end

    it "disapproves an approved event" do
      event = FactoryGirl.create(:approved_event)
      put :approve, id: event
      event.reload
      expect(event.approved).to be_false
    end
  end
# these tests use geocoder.
  describe "POST #create" do
    let(:visitor){FactoryGirl.create(:user)}
    let(:event) {FactoryGirl.attributes_for(:event, movement: movement).merge(host_id: coordinator.id)}
    before { post :create, movement_id: movement, event: event }

    context "with valid attributes" do
      it "creates an event" do
        #FIXME: refactor test to use data from the before and do not create a new object
        expect{post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event, movement: movement).merge(host_id: coordinator.id)}.to change(Event, :count).by(1)
      end

      it "calls the task prepopulator" do
        TaskPopulator.should_receive(:assign_tasks)
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event, movement: movement).merge(host_id: coordinator.id)
      end

      it "creates a event connected to the movement" do
        expect(Event.last.movement_id).to eq(movement.id)
      end

      context "as a coordinator" do
        before :each do
          @controller.stub(:current_user).and_return(coordinator)
          event = FactoryGirl.attributes_for(:event, movement: movement).merge(host_id: coordinator.id)
          post :create, movement_id: movement, event: event
        end

        it "notifies the user that event was created" do
          flash[:notice].should == "Event created!"
        end

        it "redirects to the explanation page" do
          expect(response).to redirect_to explanation_path(Event.last)
        end

        it "creates an approved event" do
          expect(Event.last.approved).to eq(true)
        end
      end

      context "as a visitor" do
        before { @controller.stub(:current_user).and_return(visitor) }

        it "sets host to event creator" do
          event = FactoryGirl.attributes_for(:event, movement: movement).merge(host_id: coordinator.id)
          post :create, movement_id: movement, event: event
          expect(Event.last.host).to eq(visitor)
        end

        it "redirects to the explanation page" do
          expect(response).to redirect_to explanation_path(Event.last)
        end

        it "creates an unapproved event" do
          expect(Event.last.approved).to eq(nil)
        end

        it "notifies the creator that coordinator will approve event" do
          flash[:notice].should == "Your event will be viewable to the public as soon as the movement coordinator approves it!"
        end
      end
    end

    context "with invalid fields" do
      let(:event_without_address) {FactoryGirl.attributes_for(:event_without_address)}

      it "does not save the event" do
        expect{post :create, movement_id: movement, event: event_without_address}.not_to change(Event, :count)
      end

      it "re-renders the new method" do
        @controller.stub(:current_user).and_return(coordinator)
        post :create, movement_id: movement, event: FactoryGirl.attributes_for(:event_without_address).merge(coordinator_id: coordinator.id)
        expect(response).to redirect_to dashboard_movement_path(movement, anchor: "events")
      end

      it "notifies user that event had errors" do
        post :create, movement_id: movement, event: event_without_address
        flash[:notice].should == "Host can't be blank Address can't be blank City can't be blank State can't be blank Zip can't be blank Name can't be blank Description can't be blank"
      end
    end
  end

  describe "GET #search" do
    #FIXME: the same tests are in the movements_controller, update accordingly
    #after refactoring
    it "responds successfully" do
      get "search", zip: "60647"
      expect(response).to be_success
    end

    context "with published movement and existing zip code" do
      before {FactoryGirl.create(:zipcode, zip: "60647", latitude: 10, longitude: 50)}
      let(:published_movement) {FactoryGirl.create(:published_movement)}
      let(:approved_event) {FactoryGirl.create(:approved_event, zip: "60647", movement: published_movement)}
      let(:nonapproved_event) {FactoryGirl.create(:event, zip: "60647", movement: published_movement)}

      it "assigns only approved events" do
        get "search", zip: "60647"
        expect(assigns(:events)).to eq([approved_event])
      end

      it "doesn't assign nonapproved events" do
        get "search", zip: "60647"
        expect(assigns(:events)).not_to include(nonapproved_event)
      end
    end
  end

  describe "PUT #update" do
    context "when current user is coordinator" do
      new_note_text = "attribute changed by coordinator"

      before do
        @controller.stub(:current_user).and_return(coordinator)
        put :update, movement_id: movement, id: event, event: {notes: new_note_text}
      end

      it "loads the requested movement" do
        expect(assigns(:event)).to eq(event)
      end

      it "changes attributes" do
        expect(event.reload.notes).to eql(new_note_text)
      end

      it "redirects to movement page anchored in event" do
        expect(response).to redirect_to dashboard_movement_path(event.movement, anchor: "events")
      end

      it "notifies user that event was updated" do
        flash[:notice].should == "Event updated."
      end
    end
  end

end

