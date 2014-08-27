class AddPhoneToMovement < ActiveRecord::Migration
  def change
 		add_column :movements, :phone, :string
  end
end
