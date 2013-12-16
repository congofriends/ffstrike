class Movement < ActiveRecord::Base
  include YoutubeParserHelper

  validates_presence_of :name, on: :create 
  has_attached_file :image, :default_url => 'cat.png'
	validates_attachment_content_type :image, content_type: ['image/png', 'image/gif', 'image/jpg', 'image/jpeg']
	validates_attachment_size :image, :less_than => 2.megabytes
  
end
