class AddIndexToOwnerships < ActiveRecord::Migration
  def change
	 	add_index :ownerships, :user_id
    add_index :ownerships, :movement_id
    add_index :ownerships, [:user_id, :movement_id], unique: true
  end
end
