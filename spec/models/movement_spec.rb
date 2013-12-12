require 'spec_helper'

describe Movement do
  it "has a working factory" do
    expect(FactoryGirl.build(:movement)).to be_valid
  end

  it "is not valid without a name" do
    expect(FactoryGirl.build(:nameless_movement)).to_not be_valid
  end
end
