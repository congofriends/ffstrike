class RoleApplication
  include Mongoid::Document
  embedded_in :team

  field :role,            :type => String
  field :why_dependable,  :type => String
  field :why_cause,       :type => String
  field :other,           :type => String
  field :phone,           :type => String
end
