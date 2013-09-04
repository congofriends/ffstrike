class Task
  include Mongoid::Document
  embedded_in :role,      :polymorphic => true

  field :done,            :type => Mongoid::Boolean, :default => false
  field :description,     :type => String
end

