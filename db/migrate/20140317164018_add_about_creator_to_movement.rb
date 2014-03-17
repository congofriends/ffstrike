class AddAboutCreatorToMovement < ActiveRecord::Migration
  def change
    add_column :movements, :about_creator, :text
  end
end
