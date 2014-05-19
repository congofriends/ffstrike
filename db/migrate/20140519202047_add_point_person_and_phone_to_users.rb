class AddPointPersonAndPhoneToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :point_person, :boolean, default: false
  end
end
