class AddNameToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :name, :string
  end
end
