class AddFieldsToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :call_to_action, :text
    add_column :movements, :extended_description, :text
  end

  change_table :movements do |t|
    t.rename :story, :tagline
  end
end
