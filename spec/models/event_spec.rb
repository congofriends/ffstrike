require 'spec_helper'

describe Event do
  let(:event) { FactoryGirl.build(:event) }
  let(:published_movement) {FactoryGirl.create(:published_movement)}
  let(:unpublished_movement) {FactoryGirl.create(:unpublished_movement)}

  it { should respond_to(:tasks) }

  it "geocodes" do
    zip = FactoryGirl.create(:zipcode)
    event = FactoryGirl.create(:event, zip: zip.zip)
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

  describe "date validation"  do
    it "not valid with date which is passed already" do
      invalid_event = FactoryGirl.build(:event_with_passed_date)
      expect(invalid_event.save).to be_false
      expect(invalid_event.errors.full_messages).to eql(["Date can't be in the past"])
    end
  end

  describe "#self.near_zip" do
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

    context "with published and unpublished movement" do
      before do
        @test_zip = "60647"
        @test_latitude = 10
        @test_longitude = 50
        zip = FactoryGirl.create(:zipcode, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude)
      end

      it "finds a nearby event if assosiated movement is published" do
        event = FactoryGirl.create(:approved_event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: published_movement)
        expect(Event.near_zip(@test_zip, 50)).to eq([event])
      end

      it "doesn't find a nearby event if assosiated movement is not published" do
        event = FactoryGirl.create(:event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: unpublished_movement)
        expect(Event.near_zip(@test_zip, 50)).to_not eql([event])
      end

      it "finds several nearby events if assosiated movement is published" do
         zips = ["60247", "60250", "60240"]
         @events = []
         zips.each do |zip|
           @events << FactoryGirl.create(:approved_event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: published_movement)
         end
         events_near_zip = Event.near_zip(@test_zip, 50).to_a.sort_by(&:id)
         expected_events = @events.sort_by(&:id)
         expect(events_near_zip).to eql(expected_events)
      end
    end
  end
end
