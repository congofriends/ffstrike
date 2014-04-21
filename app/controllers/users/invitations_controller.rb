class Users::InvitationsController < Devise::InvitationsController

  def invite_resource(&block)
    custom_params = invite_params
    custom_params[:name] = session[:movement]
    resource_class.invite!(custom_params, current_inviter, &block)
  end

  def new
    self.resource = resource_class.new
    render :new
  end

  def edit
    @movement = Movement.find resource.name
    resource.name = nil
    resource.invitation_token = params[:invitation_token]
    render :edit
  end

  def update
    self.resource = resource_class.accept_invitation!(update_resource_params)
    inviter = User.find(resource.invited_by_id)
    movement = Movement.find(params[:movement_id])
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

