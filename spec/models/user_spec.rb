require 'spec_helper'

describe User do
  context "#add_movement" do
    it "adds movement_id" do
      user = FactoryGirl.build(:user)
      movement = FactoryGirl.build(:movement)

      user.add_movement(movement)
      expect(user.movements).to include(movement)
    end
  end

  describe "User events" do
      let(:user) { FactoryGirl.create(:user) }
      let(:movement) { FactoryGirl.create(:movement) }
      let(:approved_event) { FactoryGirl.create(:approved_event, host: user, movement: movement) }
      let(:unapproved_event) { FactoryGirl.create(:event, host: user, movement: movement) }

    context "#approved_events" do
      it "returns collection of approved events" do
        expect(user.approved_events).to include(approved_event)
        expect(user.approved_events).to_not include(unapproved_event)
      end
    end

    context "#nonapproved_events" do
      it "returns collection of non approved events" do
        expect(user.nonapproved_events).to_not include(approved_event)
        expect(user.nonapproved_events).to include(unapproved_event)
      end
    end
  end
end
