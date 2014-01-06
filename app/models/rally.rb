class Rally < ActiveRecord::Base
  validates_presence_of :coordinator, :address, on: :create
  belongs_to :coordinator, class_name: User
  belongs_to :movement, class_name: Movement
  has_many :attendees, dependent: :destroy

  def self.near_zip(zipcode, distance)
    return [] if zipcode.nil?
    zipcode = zipcode.strip
    lookup = Zipcode.find_by_zip(zipcode)
    return [] if lookup.nil? || distance.nil?
    Rally.limit(3).geo_near(lookup.coordinates).max_distance(distance.to_i/3960.0).spherical.to_a
  end
end
