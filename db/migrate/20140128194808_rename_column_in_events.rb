class RenameColumnInEvents < ActiveRecord::Migration
  change_table :events do |t|
    t.rename :type, :event_type
  end
end
