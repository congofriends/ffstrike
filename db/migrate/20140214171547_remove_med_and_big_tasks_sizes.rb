class RemoveMedAndBigTasksSizes < ActiveRecord::Migration
  def change
    remove_column(:tasks, :medium_event)
    remove_column(:tasks, :big_event)
  end
end
