class AddMovementIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :movement_id, :integer
  end
end
