class RemoveCoordinatesFromZipcode < ActiveRecord::Migration
  def change
    remove_column :zipcodes, :coordinates
  end
end
