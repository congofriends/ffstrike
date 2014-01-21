require 'spec_helper'

describe Users::InvitationsController do
  context "when invited user accepts invitation" do
    it "assigns invited user to inviter's movement" do

      invitee = FactoryGirl.build(:user, email: "invitee@example.org")
      movement = FactoryGirl.create(:movement)
      inviter = FactoryGirl.create(:user, movement_id:  movement.id, email: "inviter@example.org")

      User.stub(:accept_invitation!).and_return(invitee)
      User.stub(:find).and_return(inviter)

      @request.env["devise.mapping"] = Devise.mappings[:user]

      put :update, {user: {invitation_token: "aaaaa", password: "password", password_confirmation: "password"}}.to_json

      expect(invitee.movement_id).to eq(inviter.movement_id) 
    end
  end
end
