class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.integer :rally_id

      t.timestamps
    end
    add_index :tasks, [:rally_id]
  end
end
