class ChangeRalliesToEvents < ActiveRecord::Migration
  def change
    rename_table :rallies, :events
  end
end
