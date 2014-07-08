class RemovePublishedFromMovements < ActiveRecord::Migration
  def change
  	remove_column :movements, :published, :boolean
  	add_column :movements, :published, :boolean, default: true
  end
end