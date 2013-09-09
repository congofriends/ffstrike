class Team
  include Mongoid::Document
  embeds_one :coordinator
  embeds_many :role_applications

  accepts_nested_attributes_for :coordinator
  accepts_nested_attributes_for :role_applications

  field :name,             :type => String
  field :active,           :type => Mongoid::Boolean, :default => true

  def role(role_name)
    return coordinator if role_name == :coordinator
    self.role_applications.where(:approved => true, :role => role_name).first
  end
end
