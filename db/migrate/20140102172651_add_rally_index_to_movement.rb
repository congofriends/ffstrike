class AddRallyIndexToMovement < ActiveRecord::Migration
  def change
    add_index :rallies, [:movement_id]
  end
end
