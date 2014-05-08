class AddForumOptionToEvent < ActiveRecord::Migration
  def up
    add_column :events, :forum_option, :boolean, default: false
    execute "UPDATE events SET forum_option = false"
  end

  def down
    remove_column :events, :forum_option
  end
end
