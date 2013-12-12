require 'spec_helper'

describe Movement do
  it "has a working factory" do
    expect(FactoryGirl.build(:movement)).to be_valid
  end
end
