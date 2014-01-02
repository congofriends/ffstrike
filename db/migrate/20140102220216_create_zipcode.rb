class CreateZipcode < ActiveRecord::Migration
  def change
    create_table :zipcodes do |t|
      t.string :zip
      t.string :city
      t.string :state
      t.string :state_abbreviation
      t.float :coordinates,  array: true, length: 2
    end
  end
end
