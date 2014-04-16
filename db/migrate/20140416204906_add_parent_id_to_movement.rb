class AddParentIdToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :parent_id, :integer
  end
end
