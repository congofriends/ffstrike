class ChangeAttendeeReferencesToRallies < ActiveRecord::Migration
  def change
    rename_column(:attendees, :rally_id, :event_id)
  end
end
