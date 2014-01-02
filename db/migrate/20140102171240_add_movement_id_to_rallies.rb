class AddMovementIdToRallies < ActiveRecord::Migration
  def change
    add_column :rallies, :movement_id, :integer 
  end
end
