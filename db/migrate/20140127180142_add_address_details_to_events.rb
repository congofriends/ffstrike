class AddAddressDetailsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :address_details, :string
  end
end
