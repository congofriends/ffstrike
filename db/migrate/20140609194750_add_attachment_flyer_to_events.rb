class AddAttachmentFlyerToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :flyer
    end
  end

  def self.down
    drop_attached_file :events, :flyer
  end
end
