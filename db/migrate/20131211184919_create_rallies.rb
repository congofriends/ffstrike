class CreateRallies < ActiveRecord::Migration
  def change
    create_table :rallies do |t|
      t.string :name
      t.text :notes
      t.string :address
      t.string :city
      t.string :zip
      t.belongs_to :coordinator, class_name: User
      t.timestamps
    end
  end
end
