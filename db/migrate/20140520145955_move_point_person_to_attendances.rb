class MovePointPersonToAttendances < ActiveRecord::Migration
  def change
    remove_column :users, :point_person, :boolean
    add_column :attendances, :point_person, :boolean, default: false
    add_column :attendances, :notes, :text
    add_column :assignments, :attendance_id, :integer
    remove_column :assignments, :attendee_id, :integer
    drop_table :attendees
  end
end
