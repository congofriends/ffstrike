class RoleApplication 
  include Mongoid::Document
  embedded_in :team
  embeds_many :tasks, :as => :role

  belongs_to :user

  field :role,            :type => String
  field :why_dependable,  :type => String
  field :why_cause,       :type => String
  field :other,           :type => String
  field :phone,           :type => String
  field :approved,        :type => Mongoid::Boolean, :default => false
  field :rejected,        :type => Mongoid::Boolean, :default => false

  validates_format_of :phone, :with => /\A[0-9]+\Z/i, :on => :create
end
