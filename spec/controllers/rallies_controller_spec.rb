require 'spec_helper'

describe RalliesController do
  describe "GET #new" do
    it "responds successfully" do
      movement = FactoryGirl.create(:movement)
      get "new", movement_id: movement 
      expect(response).to be_success
    end

    it "creates new rally" do
      rally = FactoryGirl.build(:new_rally)
      expect(assigns(:rally)).to eq(rally)      
    end
  end
end

