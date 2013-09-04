class Team
  include Mongoid::Document
  embeds_one :coordinator
  accepts_nested_attributes_for :coordinator

  field :name,             :type => String
  field :active,           :type => Mongoid::Boolean, :default => true
end
