class RemoveMovementIdFromUsers < ActiveRecord::Migration
  def change
    remove_column(:users, :movement_id)
  end
end
