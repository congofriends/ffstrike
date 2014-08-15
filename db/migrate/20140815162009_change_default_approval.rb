class ChangeDefaultApproval < ActiveRecord::Migration
  def change
  	change_column :events, :approved, :boolean, default: true
  end
end
