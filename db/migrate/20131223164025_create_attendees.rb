class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string :email
      t.integer :movement_id

      t.timestamps
    end
  end
end
