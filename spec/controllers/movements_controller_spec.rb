require 'spec_helper'

describe MovementsController do

  let(:user){FactoryGirl.create(:user)}
  let(:movement) { FactoryGirl.create(:published_movement) }

  before :each do
    controller.stub(:current_user).and_return(user)
    controller.stub(:authenticate_user!).and_return true
  end

  describe "GET #new" do
    before { get "new" }

    it "responds successfully" do
      expect(response).to be_success
    end

    it "create a new movement" do
      expect(assigns(:movement)).not_to be(nil)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      before { post :create, movement: FactoryGirl.attributes_for(:movement) }

      it "creates a movement" do
        #FIXME: refactor test to use data from the before and do not create a new object
        expect{post :create, movement: FactoryGirl.attributes_for(:movement)}.to change(Movement, :count).by(1)
      end

      it "redirects to the movement page" do
        expect(response).to redirect_to movement_explanation_path(Movement.last)
      end

      it "notifies user that movement has been created" do
        flash[:notice].should == I18n.t('movement.created')
      end
    end

    context "without valid name" do
      before {post :create, movement: FactoryGirl.attributes_for(:nameless_movement)}

      it "responds successfully" do
        expect(response).to be_success
      end

      it "does not save the movement" do
        #FIXME: refactor test to use data from the before and do not create a new object
        expect{ post :create, movement: FactoryGirl.attributes_for(:nameless_movement) }.to_not change(Movement, :count)
      end

      it "re-renders the new method" do
        expect(response).to render_template :new
      end
    end

    context "with published movement" do
      let(:published_movement) {FactoryGirl.attributes_for(:unpublished_movement)}

      it "is true" do
        post :create, movement: published_movement
        expect(assigns(:movement).published).to eq(true)
      end
    end

    context "with invalid video" do
      #FIXME: refactor test to use data from the before and do not create a new object
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
    # context 'as a visitor to movement page' do
    #   context 'when I view an unpublished movement' do
    #     before :each do
    #       movement = FactoryGirl.create(:unpublished_movement)
    #       user = FactoryGirl.create(:user)
    #       controller.stub(:current_user).and_return(user)
    #       get :show, id: movement
    #     end

    #     it 'redirects me to the home page' do
    #       expect(response).to redirect_to root_path
    #     end

    #     it 'notifies me that the movement does not exist' do
    #       flash[:notice].should eq(I18n.t('movement.not_public'))
    #     end
    #   end
    # end
	end

  describe "DELETE #destroy" do
    before do
      sign_in user
      @request.env['HTTP_REFERER'] = movement_path(movement)
    end
    it "deletes the team" do
      delete :destroy, id: movement
      expect { Movement.all == [] }
    end
  end

  describe "PUT #update" do
    context "video attribute" do
      video_url = "https://www.youtube.com/watch?v=_ZSbC09qgLI"
      before do
        @controller.request.stub referer: movement_path(movement)
        put :update, id: movement, movement: { video: video_url }
      end

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

    context "name for existing movement with a video" do
      it "should update the name and should not reset the video field value" do
        video = movement.video
        @controller.request.stub referer: movement_path(movement)
        put :update, id: movement, movement: { name: "new name"  }
        expect(movement.reload.video).to eq(video)
        expect(movement.name).to eq("new name")
      end
    end
  end

  describe "PUT #publish" do
    it "publish an unpublished movements" do
      movement = FactoryGirl.create(:unpublished_movement)
      put :publish, id: movement
      expect(movement.reload.published).to be_true
    end
  end

  describe "PUT #cancel_ownership" do
    it "removes user as coordinator for movement" do
      movement = FactoryGirl.create(:movement)
      user = FactoryGirl.create(:user)
      ownership = FactoryGirl.create(:ownership, user: user, movement: movement)

      expect{put :cancel_ownership, team_id: movement.id, coordinator_id: user.id}.to change(Ownership, :count).by(-1)
    end
  end

  describe "PUT #cancel_membership" do
    it "removes user as a member of movement" do
      movement = FactoryGirl.create(:movement)
      user = FactoryGirl.create(:user)
      membership = FactoryGirl.create(:membership, user: user, movement: movement)

      expect{put :cancel_membership, team_id: movement.id, member_id: user.id}.to change(Membership, :count).by(-1)
    end
  end

  describe "GET #export_csv" do
    context "when format is csv" do
      it "should return a csv attachment" do
        @controller.should_receive(:send_data).with(movement.to_csv, filename: "#{movement.name} attendee-list.csv").
          and_return { @controller.render nothing: true } # to prevent a 'missing template' error
        get :export_csv, id: movement, format: :csv
      end
    end
  end

  describe "GET #export_members_csv" do
    context "when format is csv" do
      it "should return a csv attachment" do
        @controller.should_receive(:send_data).with(movement.members_to_csv, filename: "#{movement.name} members-list.csv").
            and_return { @controller.render nothing: true } # to prevent a 'missing template' error
        get :export_members_csv, id: movement, format: :csv
      end
    end
  end

  describe "GET #my_groups" do
    context "when user does not own movement" do
      it "should redirect to sign in page" do
        wrong_user = FactoryGirl.create(:user)
        ownership = FactoryGirl.create(:ownership, movement: movement, user: user)
        controller.stub(:current_user).and_return(wrong_user)
        get :my_groups
        expect(response).to redirect_to root_path
      end
    end
  end
end
