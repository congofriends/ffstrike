class Leaflet
  include Mongoid::Document

  field :location,      :type => String
  field :file,          :type => String
end
