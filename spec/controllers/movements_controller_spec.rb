require 'spec_helper'

describe MovementsController do
   
  before :each do
    controller.stub(:current_user).and_return( FactoryGirl.create(:user) )
    controller.stub(:authenticate_user!).and_return true 
  end

  let(:movement) { FactoryGirl.create(:movement) }

  describe "GET #new" do
    it "responds successfully" do
      get "new"
      expect(response).to be_success
    end
  end

  describe "GET #search" do

    let!(:zip) { FactoryGirl.create(:zipcode, zip: "60647", latitude: 10, longitude: 50) }
    let(:event) { movement.events.create(zip: "60647", approved: true) }
    let(:unapproved_event) { movement.events.create(zip: "60647", approved: false) }

    before { get "search", id: movement, zip: event.zip }

    it "redirects to search results" do
      expect(response).to be_success 
    end

    it "assigns events" do
      expect(assigns(:events)).to include(event)
    end

    it "does not assign unapproved events" do
      expect(assigns(:events)).not_to include(unapproved_event)
    end

  end

  describe "GET #visitor" do
    it "responds successfully" do
      movement = FactoryGirl.create(:movement)
      get "visitor", id: movement

      expect(response).to be_success
    end
  end

  describe "POST #create" do
    it "responds successfully" do
      post :create, movement: FactoryGirl.attributes_for(:nameless_movement)

      expect(response).to be_success 
    end

    context "with valid attributes" do
      let(:movement_attributes) { FactoryGirl.attributes_for(:movement) }

      it "creates a movement" do
        expect{ post :create, movement: movement_attributes }.to change(Movement, :count).by(1) 
      end

      it "redirects to the movement page" do
        post :create, movement: movement_attributes 
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

    context "with invalid video" do
      it "does not save the movement" do
        expect{ post :create, movement: FactoryGirl.attributes_for(:movement_with_invalid_video) }.to_not change(Movement, :count) 
      end

      it "re-renders the new method" do
        post :create, movement: FactoryGirl.attributes_for(:movement_with_invalid_video) 

        expect(response).to render_template :new 
      end
    end

  end

	describe "GET #show" do
		it "assigns the new movement to @movement" do
			get :show, id: movement
			expect(assigns(:movement)).to eq(movement)	
		end

		it "renders the #show view" do
			get :show, id: movement
			expect(response).to render_template :show
		end
	end

  describe "PUT #update" do
    video_url = "https://www.youtube.com/watch?v=_ZSbC09qgLI"
    before { put :update, id: movement, movement: FactoryGirl.attributes_for(:movement, video: video_url) }

    it "loads the requested movement" do
      expect(assigns(:movement)).to eq(movement)
    end

    it "updates the movement" do
      expect(movement.reload.video).to eq("_ZSbC09qgLI")
    end

    it "redirects to show" do
      expect(response).to redirect_to movement_path(movement)
    end
  end

  describe "GET #export_csv" do
    context "when format is csv" do
      it "should return a csv attachment" do
        @controller.should_receive(:send_data).with(movement.to_csv, filename: "Attendee List").
          and_return { @controller.render nothing: true } # to prevent a 'missing template' error
        get :export_csv, id: movement, format: :csv
      end
    end
  end

end
