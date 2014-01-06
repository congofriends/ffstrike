require 'spec_helper'

describe Rally do
  it "assigns a zipcode" do
    zip = FactoryGirl.create(:zipcode)
    rally = FactoryGirl.create(:rally, zip: "60647")
    expect(rally.latitude).not_to be_nil 
    expect(rally.longitude).not_to be_nil
  end

  context "#self.near_zip" do

    context "with no distance" do
      it "returns []" do
        test_zip = "60647"
        expect(Rally.near_zip(test_zip, nil)).to eq([])
      end
    end

    context "with a bad zip" do
      it "returns []" do
        expect(Rally.near_zip("abc", 50)).to eq([])
      end
    end

    context "with no zip" do
      it "returns []" do
        expect(Rally.near_zip(nil, 50)).to eq([])
      end
    end

    it "finds a nearby rally" do
      test_zip = "60647"
      test_latitude = 10
      test_longitude = 50
      rally = FactoryGirl.create(:rally, zip: test_zip, latitude: test_latitude, longitude: test_longitude)
      zip = FactoryGirl.create(:zipcode, zip: test_zip, latitude: test_latitude, longitude: test_longitude)
      expect(Rally.near_zip(test_zip, 50)).to eq([rally])
    end

  end
end
