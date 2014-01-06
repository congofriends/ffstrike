class AddLatitudeAndLongitudeToRally < ActiveRecord::Migration
  def change
    add_column :rallies, :latitude, :float
    add_column :rallies, :longitude, :float
  end
end
