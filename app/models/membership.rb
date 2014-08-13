class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :movement

  def self.assign_owners_to_members
  	Ownership.all.each{|ownership| Membership.where(movement_id: ownership.movement_id, user_id: ownership.user_id).first_or_create!(movement_id: ownership.movement_id, user_id: ownership.user_id) }
  end

end
