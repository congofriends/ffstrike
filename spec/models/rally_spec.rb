require 'spec_helper'

describe Rally do
  context "#self.near_zip" do
    it "finds a nearby rally" do
      test_zip = "60647"
      rally = FactoryGirl.create(:rally, zip: test_zip)
      zip = FactoryGirl.create(:zipcode, zip: test_zip)
      expect(Rally.near_zip(test_zip, 50)).to eq([rally])
    end
  end
end
