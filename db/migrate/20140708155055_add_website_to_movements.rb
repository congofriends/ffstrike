class AddWebsiteToMovements < ActiveRecord::Migration
  def change
  	add_column :movements, :website, :string
  end
end