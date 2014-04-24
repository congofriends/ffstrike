class AddLocationToMovements < ActiveRecord::Migration
  def change
  	add_column :movements, :location, :string
  end
end
