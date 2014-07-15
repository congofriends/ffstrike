class AddFlickrToMovements < ActiveRecord::Migration
  def change
  	add_column :movements, :flickr, :string
  end
end
