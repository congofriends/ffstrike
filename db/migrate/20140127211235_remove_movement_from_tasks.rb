class RemoveMovementFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :movement_id
  end
end
