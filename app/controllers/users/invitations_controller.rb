class Users::InvitationsController < Devise::InvitationsController
  def update

    self.resource = resource_class.accept_invitation!(update_resource_params)

    inviter = User.find(resource.invited_by_id)
    movement = Movement.find(inviter.movements.first.id)

    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active                                                                                        
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      Ownership.create(user: resource, movement: movement)
      redirect_to dashboard_movement_path(movement)
    else
      respond_with_navigational(resource){ render :edit }
    end
  end
end

