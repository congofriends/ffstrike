class Movement < ActiveRecord::Base
  validates_presence_of :name, on: :create 
  has_attached_file :image, :default_url => 'cat.png'
		
end
