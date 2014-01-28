require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.build(:event) }

  it { should respond_to(:tasks) }

  it "geocodes" do
    zip = FactoryGirl.create(:zipcode)
    event = FactoryGirl.create(:event, zip: "60647")
    expect(event.latitude).not_to be_nil 
    expect(event.longitude).not_to be_nil
  end

  describe "task assosiation" do
    before do 
      event.save
      2.times { FactoryGirl.create(:task, event: event) }
    end

    it "should destroy assosiated tasks" do
      tasks = event.tasks.to_a
      event.destroy
      expect(tasks).not_to be_empty
      tasks.each { |task| expect(Task.where(id: task.id)).to be_empty }
    end
  end


  context "#self.near_zip" do

    context "with no distance" do
      it "returns []" do
        test_zip = "60647"
        expect(Event.near_zip(test_zip, nil)).to eq([])
      end
    end

    context "with a bad zip" do
      it "returns []" do
        expect(Event.near_zip("abc", 50)).to eq([])
      end
    end

    context "with no zip" do
      it "returns []" do
        expect(Event.near_zip(nil, 50)).to eq([])
      end
    end

    it "finds a nearby event" do
      test_zip = "60647"
      test_latitude = 10
      test_longitude = 50
      event = FactoryGirl.create(:event, zip: test_zip, latitude: test_latitude, longitude: test_longitude)
      zip = FactoryGirl.create(:zipcode, zip: test_zip, latitude: test_latitude, longitude: test_longitude)
      expect(Event.near_zip(test_zip, 50)).to eq([event])
    end

  end
end
