class ChangeTaskColumnNamesFromRallyToEvent < ActiveRecord::Migration
  def change
    rename_column(:tasks, :small_rally, :small_event)
    rename_column(:tasks, :medium_rally, :medium_event)
    rename_column(:tasks, :big_rally, :big_event)
  end
end
