class RoleApplication 
  include Mongoid::Document
  embedded_in :team
  embeds_many :tasks, :as => :role

  belongs_to :user

  field :role,            :type => String
  field :why_cause,       :type => String
  field :other,           :type => String
  field :phone,           :type => String
  field :approved,        :type => Mongoid::Boolean, :default => false
  field :rejected,        :type => Mongoid::Boolean, :default => false

  validates_format_of :phone, :with => /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/,
    :on => :create, :allow_blank => true, :message => "You must enter a valid phone number. Valid phone numbers are 10 digits long."

  validates_presence_of :why_cause, 
     :message => "It is really important for us to know why you are interested to help Fast Food Strike Movement. Please fill in the first question"
  validates_presence_of :other, :message => "We would like to know about yourself. Please fill in the second question"
end
