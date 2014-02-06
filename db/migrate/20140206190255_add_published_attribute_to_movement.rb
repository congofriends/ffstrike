class AddPublishedAttributeToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :published, :boolean, :default => false
  end
end
