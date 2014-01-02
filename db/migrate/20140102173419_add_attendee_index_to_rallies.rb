class AddAttendeeIndexToRallies < ActiveRecord::Migration
  def change
    add_index :attendees, [:rally_id]
  end
end
