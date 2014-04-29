class RemoveDateAndTimeFromEvents < ActiveRecord::Migration
  def change
  	remove_column :events, :date
  	remove_column :events, :time
  end
end
