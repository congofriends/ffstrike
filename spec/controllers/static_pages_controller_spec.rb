require 'spec_helper'

describe StaticPagesController do
  describe "GET #index" do

    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

  end

  describe "GET #mission" do
    it "returns success" do
      get 'mission'
      expect(response).to be_success
    end
  end

end
