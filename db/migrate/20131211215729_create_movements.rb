class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.string :name
      t.string :category
      t.text :story
      t.timestamps
    end
  end
end
