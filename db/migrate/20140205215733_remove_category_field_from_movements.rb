class RemoveCategoryFieldFromMovements < ActiveRecord::Migration
  def change
    remove_column :movements, :category
  end
end
