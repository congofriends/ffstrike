class Zipcode < ActiveRecord::Base
  def self.find_by_zip(zip)
    Zipcode.find_by(zip: zip)
  end
end
