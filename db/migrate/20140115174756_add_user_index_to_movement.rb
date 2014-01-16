class AddUserIndexToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :user_id, :integer
  end
end
