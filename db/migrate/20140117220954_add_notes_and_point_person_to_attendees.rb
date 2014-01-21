class AddNotesAndPointPersonToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :notes, :text
    add_column :attendees, :point_person, :boolean
  end
end
