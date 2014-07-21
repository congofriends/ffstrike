class AddTextableToUser < ActiveRecord::Migration
  def change
    add_column :users, :textable, :boolean, default: true
  end
end
