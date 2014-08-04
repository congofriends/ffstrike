class UnauthenticatedSubmovementsController < ApplicationController

  def new; end

  def create
    @user = User.create user_params
    @submovement = Movement.create movement_params
    @submovement.update(parent_id: Movement.first.id)
    @submovement.users.push(@user)
    sign_in(:user, @user)
    UserMailer.team_creation_message(@user.id, @submovement.id) if current_user
    redirect_to movement_path(@submovement), notice: t('movement.created')
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def movement_params
    params.require(:movement).permit(:name, :draft, :category, :tagline, :call_to_action, :extended_description, :image, :avatar, :video, :about_creator, :website, :flickr, :parent_id, :location, :sponsored)
  end
end
