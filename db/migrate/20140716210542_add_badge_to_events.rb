class AddBadgeToEvents < ActiveRecord::Migration
  def change
  	add_column :events, :sponsored, :boolean, default: false
  end
end
