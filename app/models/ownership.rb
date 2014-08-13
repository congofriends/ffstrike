class Ownership < ActiveRecord::Base
  belongs_to :user
  belongs_to :movement
  after_create :assign_membership

  def assign_membership
		Membership.where(movement_id: movement.id, user_id: user.id).first_or_create!(movement_id: movement.id, user_id: user.id)
  end

end
