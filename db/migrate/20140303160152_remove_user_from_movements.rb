class RemoveUserFromMovements < ActiveRecord::Migration
  def change
    remove_column(:movements, :user_id)
  end
end
