require 'spec_helper'

describe User do
  context "#add_movement" do
    it "adds movement_id" do
      user = FactoryGirl.build(:user)
      movement = FactoryGirl.build(:movement)

      user.add_movement(movement)
      expect(user.movements).to include(movement)
    end
  end
end
