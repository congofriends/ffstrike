require 'spec_helper'

describe HomeController do
  include Devise::TestHelpers
  it "should direct to associated movement page after login" do
    user = FactoryGirl.create(:user, movement_id: "1")
    movement = FactoryGirl.create(:movement, id: "1")
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user 
    response.should redirect_to(movement_path(movement)) 
  end
end
