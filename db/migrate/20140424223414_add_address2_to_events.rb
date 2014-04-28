class AddAddress2ToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :address2, :string
  end
end
