class ChangeApprovalDefault < ActiveRecord::Migration
  def change
  	change_column :events, :approved, :boolean, :default => false
  end
end
