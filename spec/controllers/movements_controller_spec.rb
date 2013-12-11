require 'spec_helper'

describe MovementsController do
  describe "#new" do
    before(:each) do
      @movement = FactoryGirl.build(:movement)
    end
 
    it "creates a new movement" do
      get "/movements/new"

      expects(assigns[:movement]).to be(@movement) 
    end
  end
end
