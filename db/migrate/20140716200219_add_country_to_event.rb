class AddCountryToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :country, :string
  end
end
