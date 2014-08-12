class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :movement
      t.belongs_to :user
      t.datetime :membership_date
      t.timestamps
    end
  end
end
