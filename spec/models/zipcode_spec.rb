require 'spec_helper'

describe Zipcode do
  context "#find_by_zip" do
    it "finds a zipcode" do
      zip = FactoryGirl.create(:zipcode, zip: "60647")
      expect(Zipcode.find_by_zip("60647")).to eq(zip)
    end
  end
end
