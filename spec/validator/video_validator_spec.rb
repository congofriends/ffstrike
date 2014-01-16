require 'spec_helper'

describe VideoValidator do
  it "returns true if params don't have a video" do
    movement =  Movement.new(FactoryGirl.attributes_for(:movement_without_video))
    movement.user = FactoryGirl.build(:user)    
    expect(movement.valid?).to be_true
  end

  it "returns false if params have invalid video" do
    expect(Movement.new(FactoryGirl.attributes_for(:movement_with_invalid_video)).valid?).to be_false
  end

  it "returns true if params have valid video" do
    movement =  Movement.new(FactoryGirl.attributes_for(:movement))
    movement.user = FactoryGirl.build(:user)
    expect(movement.valid?).to be_true
  end
end
