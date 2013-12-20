class RemoveRallyAndAddMovementToTasks < ActiveRecord::Migration
  change_table :tasks do |t|
    t.remove :rally_id
    t.integer :movement_id
    add_index :tasks, [:movement_id]
  end
end
