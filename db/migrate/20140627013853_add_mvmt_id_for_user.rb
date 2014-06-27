class AddMvmtIdForUser < ActiveRecord::Migration
  def change
  	add_column :users, :mvmt_id, :integer
  end
end
