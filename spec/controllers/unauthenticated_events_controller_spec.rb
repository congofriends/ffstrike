require 'spec_helper'

describe UnauthenticatedEventsController do

  describe 'Post #create' do
    let!(:invalid_user){FactoryGirl.attributes_for(:invalid_user)}
    let!(:user){FactoryGirl.attributes_for(:user)}
    let!(:movement){FactoryGirl.create(:movement)}
    let!(:event){FactoryGirl.attributes_for(:event)}
    let!(:invalid_event){FactoryGirl.attributes_for(:invalid_event, movement: movement)}

    context 'invalid user credentials' do
      before :each do
        post :create, user: invalid_user, event: event, movement_id: movement
      end
      it 'renders new page' do
        response.should render_template "new"
      end
      it 'shows a message for invalid credentials' do
        flash[:alert].should eq(I18n.t('user.invalid_credentials'))
      end
    end
    context 'invalid event details' do

      it 'creates user' do
        expect{post :create, user: user, event: invalid_event, movement_id: movement}.to change(User, :count).by(1)
      end

      it 'logs user in' do
        post :create, user: user, event: invalid_event, movement_id: movement
        expect(controller.current_user).to eq(User.last)
      end

      it 'redirects to new event page' do
        post :create, user: user, event: invalid_event, movement_id: movement
        response.should redirect_to new_movement_event_path(movement)
      end

      it 'notifies the user what happened' do
        post :create, user: user, event: invalid_event, movement_id: movement
        flash[:alert].should eq(I18n.t('event.failure'))
      end
    end
    context 'valid user & event' do
      it "redirects to event explanation page", :broken => true do
        post :create, user: user, event: event, movement_id: movement
        expect(response).to redirect_to explanation_path(Event.last)
      end
    end
  end
end
