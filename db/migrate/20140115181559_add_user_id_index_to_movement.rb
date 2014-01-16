class AddUserIdIndexToMovement < ActiveRecord::Migration
  def change
    add_index :movements, [:user_id]
  end
end
