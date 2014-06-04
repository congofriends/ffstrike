class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :event_id
      t.integer :movement_id

      t.timestamps
    end
  end
end
