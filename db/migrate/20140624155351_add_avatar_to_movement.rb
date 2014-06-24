class AddAvatarToMovement < ActiveRecord::Migration
  def self.up
    change_table :movements do |t|
      t.attachment :avatar
    end
  end

  def self.down
    drop_attached_file :movements, :avatar
  end
end