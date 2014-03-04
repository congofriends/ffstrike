require 'spec_helper'

#describe Users::InvitationsController do
#  context "when invited user accepts invitation" do
#    it "assigns invited user to inviter's movement" do
#
#      invitee = FactoryGirl.build(:user, email: "invitee@example.org")
#      movement = FactoryGirl.create(:movement)
#      inviter = FactoryGirl.create(:user, email: "inviter@example.org")
#      ownership = FactoryGirl.create(:ownership, user: inviter, movement: movement)
#
#      User.stub(:accept_invitation!).and_return(invitee)
#      User.stub(:find).and_return(inviter)
#
#      @request.env["devise.mapping"] = Devise.mappings[:user]
#
#      put :update, {user: {invitation_token: "aaaaa", password: "password", password_confirmation: "password"}}.to_json
#
#      expect(inviter.movements.to_a).to include(invitee.movements) 
#    end
#  end
#end
