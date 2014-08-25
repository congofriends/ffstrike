class Users::InvitationsController < Devise::InvitationsController

  def new
    @movement = Movement.find params[:mvmt_id]
    self.resource = resource_class.new
    render :new
  end

  def edit
    @movement = Movement.find resource.mvmt_id
    unless resource.encrypted_password.empty?
      set_flash_message :notice, :signed_in_and_coordinator, movement_name: @movement.name
      sign_in(resource_name, resource)
      Ownership.where(user: resource, movement: @movement).first_or_create(user:resource, movement: @movement)
      redirect_to root_path and return
    else
      resource.invitation_token = params[:invitation_token]
      render :edit
    end
  end

  def create
    self.resource = invite_resource

    if resource.errors.empty?
      yield resource if block_given?
      set_flash_message :success, :send_instructions, :email => self.resource.email if self.resource.invitation_sent_at
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  def update
    self.resource = resource_class.accept_invitation!(update_resource_params)
    inviter = User.find(resource.invited_by_id)
    @movement = Movement.find(params[:movement_id])
    if resource.errors.empty?
      flash_message = resource.active_for_authentication? ? :updated : :updated_not_active
      set_flash_message :notice, flash_message
      sign_in(resource_name, resource)
      Ownership.where(user: resource, movement: @movement).first_or_create(user:resource, movement: @movement)
      redirect_to root_path
    else
      respond_with_navigational(resource){ render :edit }
    end
  end

  private

  def invite_resource(&block)
    user = User.find_by_email(invite_params[:email])
    if user
      user.update(mvmt_id: params[:user][:mvmt_id])
      user.invite!(current_inviter)
      user
    else
      custom_params = invite_params
      custom_params[:mvmt_id] = params[:user][:mvmt_id]
      resource_class.invite!(custom_params, current_inviter, &block)
    end
  end
end

