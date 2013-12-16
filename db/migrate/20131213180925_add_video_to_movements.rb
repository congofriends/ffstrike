class AddVideoToMovements < ActiveRecord::Migration
  def self.up
    change_table :movements do |t|
      t.string :video
    end
  end

  def self.down
    drop_attached_file :movements, :string
  end
end
