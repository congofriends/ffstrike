class CreateRallies < ActiveRecord::Migration
  def change
    create_table :rallies do |t|
      t.string :name
      t.text :story

      t.timestamps
    end
  end
end
