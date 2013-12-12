class Movement < ActiveRecord::Base
  validates_presence_of :name, on: :create 
end
