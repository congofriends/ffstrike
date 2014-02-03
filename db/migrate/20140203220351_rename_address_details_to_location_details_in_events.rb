class RenameAddressDetailsToLocationDetailsInEvents < ActiveRecord::Migration
  change_table :events do |t|
    t.rename :address_details, :location_details
  end
end
