require 'spec_helper'

describe Zipcode do
  describe "#find_by_zip" do
    it "finds a zipcode" do
      zip = FactoryGirl.create(:zipcode, zip: "99999")
      expect(Zipcode.find_by_zip("99999")).to eq(zip)
    end
  end
end
