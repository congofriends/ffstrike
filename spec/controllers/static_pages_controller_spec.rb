require 'spec_helper'

describe StaticPagesController do
  describe "GET #index" do

    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

  end

  describe "GET #about" do
    it "returns success" do
      get 'about'
      expect(response).to be_success
    end
  end

end
