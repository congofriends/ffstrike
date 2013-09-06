class Team
  include Mongoid::Document
  embeds_one :coordinator
  embeds_many :role_applications

  accepts_nested_attributes_for :coordinator
  accepts_nested_attributes_for :role_applications

  field :name,             :type => String
  field :active,           :type => Mongoid::Boolean, :default => true
end
