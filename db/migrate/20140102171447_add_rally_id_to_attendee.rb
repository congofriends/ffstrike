class AddRallyIdToAttendee < ActiveRecord::Migration
  def change
    add_column :attendees, :rally_id, :integer
  end
end
