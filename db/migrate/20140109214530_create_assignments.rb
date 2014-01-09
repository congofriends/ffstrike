class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :attendee_id
      t.integer :task_id

      t.timestamps
    end

    add_index :assignments, :attendee_id
    add_index :assignments, :task_id
    add_index :assignments, [:attendee_id, :task_id], unique: true
  end
end
