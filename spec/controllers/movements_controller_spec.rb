require 'spec_helper'

describe MovementsController do
  before :each do
    controller.stub(:authenticate_user!).and_return true 
  end

  describe "GET #new" do
    it "responds successfully" do
      get "new"

      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "responds successfully" do
      post :create, movement: FactoryGirl.attributes_for(:nameless_movement)

      expect(response).to be_success 
    end

    context "with valid attributes" do
      it "creates a movement" do
        expect{ post :create, movement: FactoryGirl.attributes_for(:movement) }.to change(Movement, :count).by(1) 
      end

      it "redirects to the movement page" do
        post :create, movement: FactoryGirl.attributes_for(:movement)

        expect(response).to redirect_to movement_path(Movement.last)
      end
    end

    context "without valid name" do
      it "does not save the movement" do
        expect{ post :create, movement: FactoryGirl.attributes_for(:nameless_movement) }.to_not change(Movement, :count) 
      end

      it "re-renders the new method" do
        post :create, movement: FactoryGirl.attributes_for(:nameless_movement) 

        expect(response).to render_template :new 
      end
    end
  end

	describe "GET #show" do
		it "assigns the new movement to @movement" do
			movement = FactoryGirl.create(:movement)
			get :show, id: movement
			expect(assigns(:movement)).to eq(movement)	
		end

		it "renders the #show view" do
			get :show, id: FactoryGirl.create(:movement)
			expect(response).to render_template :show
		end
	end
end
