class AddAttachmentFlyerToAttachments < ActiveRecord::Migration
  def self.up
    change_table :attachments do |t|
      t.attachment :flyer
    end
  end

  def self.down
    drop_attached_file :attachments, :flyer
  end
end
