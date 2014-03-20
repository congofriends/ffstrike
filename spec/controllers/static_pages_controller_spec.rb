require 'spec_helper'

describe StaticPagesController do
  describe "GET #index" do
    before(:each) { get 'index' }

    it "returns http success" do
      expect(response).to be_success
    end

    it "assigns 3 movements to @featured_movements" do
      FactoryGirl.create_list(:movement, 3)
      expect(assigns(:featured_movements).count).to be(3)
    end
  end

  describe "GET #about" do
    it "returns success" do
      get 'about'
      expect(response).to be_success
    end
  end

end
