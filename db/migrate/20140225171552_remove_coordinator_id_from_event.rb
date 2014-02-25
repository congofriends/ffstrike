class RemoveCoordinatorIdFromEvent < ActiveRecord::Migration
  def change
    remove_column :events, :coordinator_id
  end
end
