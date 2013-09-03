class Team
  include Mongoid::Document

  field :why,              :type => String
  field :where,            :type => String
  field :name,             :type => String
  field :about_private,    :type => String
  field :phone,            :type => String

  field :active,           :type => Boolean, :default => false

  belongs_to :coordinator, :class_name => "User"
end
