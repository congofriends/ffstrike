require 'spec_helper'

describe RalliesController do
  describe "GET #new" do
    before :each do
      movement = FactoryGirl.create(:movement)
      get "new", movement_id: movement 
    end

    it "responds successfully" do
       expect(response).to be_success
    end

    it "creates new rally" do
      expect(assigns(:rally)).not_to be(nil)       
    end
  end

  describe "POST #create" do
    let(:movement){FactoryGirl.create(:movement)}
    let(:coordinator){FactoryGirl.create(:user)}

    context "with valid attributes" do
      it "creates a rally" do
        expect{post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:rally).merge(coordinator_id: coordinator.id)}.to change(Rally, :count).by(1)
      end

      it "creates a rally connected to the movement" do
        post :create, movement_id: movement.id, rally: FactoryGirl.attributes_for(:rally).merge(coordinator_id: coordinator.id)
        expect(Rally.last.movement_id).to eq(movement.id)
      end

      it "redirects to the movement page" do
        post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:rally).merge(coordinator_id: coordinator.id)
        expect(response).to redirect_to movement_path(movement, anchor: "rallies")
      end

      it "notifies the user that rally was created" do
        post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:rally).merge(coordinator_id: coordinator.id)
        flash[:notice].should == "Rally created!"
      end
    end

    context "with invalid fields" do
      it "does not save the rally" do
        expect{post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:rally)}.not_to change(Rally, :count)
      end

      it "re-renders the new method" do
        post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:invalid_rally)
        expect(response).to redirect_to movement_path(movement, anchor: "rallies")
      end

      it "notifies user that rally had errors" do
        post :create, movement_id: movement, rally: FactoryGirl.attributes_for(:invalid_rally)
        flash[:notice].should == "Coordinator can't be blank Address can't be blank"
      end
    end 
  end

  describe "GET #search" do
    it "responds successfully" do
      get "search", zip: "60647"  
      expect(response).to be_success
    end

    it "assigns @rallies" do
      zip = FactoryGirl.create(:zipcode, zip: "60647", latitude: 10, longitude: 50)
      rally = FactoryGirl.create(:rally, zip: "60647") 
      get "search", zip: "60647"
      expect(assigns(:rallies)).to eq([rally])
    end
  end
end

