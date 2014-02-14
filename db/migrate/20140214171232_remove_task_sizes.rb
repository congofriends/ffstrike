class RemoveTaskSizes < ActiveRecord::Migration
  def change
    remove_column(:tasks, :small_event)
  end
end
