class AddAttachmentImageToEventTypes < ActiveRecord::Migration
  def self.up
    change_table :event_types do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :event_types, :image
  end
end