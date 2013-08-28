class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.string :code
      t.string :icon
      t.string :call_to_action
      t.string :tag_line

      t.timestamps
    end
  end
end
