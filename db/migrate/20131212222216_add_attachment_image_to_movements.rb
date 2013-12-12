class AddAttachmentImageToMovements < ActiveRecord::Migration
  def self.up
    change_table :movements do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :movements, :image
  end
end
