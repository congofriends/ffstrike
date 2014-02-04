class AddPhoneNumberToAttendees < ActiveRecord::Migration
  def change
    add_column :attendees, :phone_number, :text
  end
end
