class AddRallySizeToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :small_rally, :boolean
    add_column :tasks, :medium_rally, :boolean
    add_column :tasks, :big_rally, :boolean
  end
end
