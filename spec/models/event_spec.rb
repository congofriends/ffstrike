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

  describe "time validation"  do
    it "is not valid with date which is passed already" do
      invalid_event = FactoryGirl.build(:event_with_passed_date)
      expect(invalid_event.save).to be_false
      expect(invalid_event.errors.full_messages).to eql(["Start date can't be in the past"])
    end

    it "is not valid with end time before start time" do
      invalid_event = FactoryGirl.build(:event_with_end_time_before_start_time)
      expect(invalid_event.save).to be_false
      expect(invalid_event.errors.full_messages).to eql(["End time can't be before start time"])
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

    context "with a movement" do
      before do
        @test_zip = "60647"
        @test_latitude = 38
        @test_longitude = -50
        zip = FactoryGirl.create(:zipcode, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude)

        FactoryGirl.create(:zipcode, zip: "90210", latitude: 34.0901, longitude: -118.4065)
      end

      context "with a published event" do
        it "finds a nearby event in the same zip code if assosiated movement is published" do
          event = FactoryGirl.create(:approved_event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: published_movement)
          expect(Event.near_zip(@test_zip, 50)).to eq([event])
        end

        it "doesn't find a far away event even if assosiated movement is published" do
          event = FactoryGirl.create(:approved_event, zip: @test_zip, movement: published_movement)
          event.update_attributes(latitude: @test_latitude, longitude: @test_longitude)
          expect(Event.near_zip("90210", 50)).to eq([])
        end

        it "finds several nearby events if assosiated movement is published" do
           zips = [["60209",42.0497,-87.6794], ["60208",42.0586,-87.6845], ["60301",41.8886,-87.7986]]
           @events = []
           zips.each do |zip_tuple|
             FactoryGirl.create(:zipcode, zip: zip_tuple[0], latitude: zip_tuple[1], longitude: zip_tuple[2])
             @events << FactoryGirl.create(:approved_event, zip: zip_tuple[0], latitude: zip_tuple[1], longitude: zip_tuple[2], movement: published_movement)
           end
           events_near_zip = Event.near_zip(@test_zip, 50).to_a.sort_by(&:id)
           expected_events = @events.sort_by(&:id)
           expect(events_near_zip).to eql(expected_events)
        end
      end

      context "with an unpublished event" do
        it "doesn't find a nearby event if assosiated movement is not published" do
          event = FactoryGirl.create(:event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: unpublished_movement)
          expect(Event.near_zip(@test_zip, 50)).to_not eql([event])
        end

        it "doesn't find a far away event if assosiated movement is not published" do
          event = FactoryGirl.create(:event, zip: @test_zip, latitude: @test_latitude, longitude: @test_longitude, movement: unpublished_movement)
          expect(Event.near_zip("90210", 50)).to_not eql([event])
        end
      end
    end
  end
end
