class AddSponsoredToMovements < ActiveRecord::Migration
  def change
  	add_column :movements, :sponsored, :boolean, default: false
  end
end