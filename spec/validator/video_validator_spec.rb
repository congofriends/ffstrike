require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the MovementsHelper. For example:
#
# describe MovementsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe VideoValidator do
  it "returns true if params don't have a video" do
    expect(Movement.new(FactoryGirl.attributes_for(:movement_without_video)).valid?).to be_true
  end

  it "returns false if params have invalid video" do
    expect(Movement.new(FactoryGirl.attributes_for(:movement_with_invalid_video)).valid?).to be_false
  end

  it "returns true if params have valid video" do
    expect(Movement.new(FactoryGirl.attributes_for(:movement)).valid?).to be_true
  end
end
