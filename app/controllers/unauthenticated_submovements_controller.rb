class UnauthenticatedSubmovementsController < ApplicationController

  def new; end

  def create
    @user = User.create user_params
    @submovement = Movement.create movement_params
    @submovement.update(parent_id: session[:movement_id])
    @submovement.users.push(@user)
    sign_in(:user, @user)
    redirect_to dashboard_movement_path(@submovement)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def movement_params
    params.require(:movement).permit(:name, :draft, :category, :tagline, :call_to_action, :extended_description, :image, :video, :about_creator, :parent_id)
  end
end 
