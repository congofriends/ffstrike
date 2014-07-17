class AddHostTaskAndCompletedToTasks < ActiveRecord::Migration
  def change
  	add_column :tasks, :host_task, :boolean, default: false
  	add_column :tasks, :completed, :boolean, default: false
  end
end
