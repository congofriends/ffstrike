class UnauthenticatedSubmovementsController < ApplicationController

  def new
    redirect_to root_path, notice: t('event.already_signed_in') if current_user
  end

  def create
    params[:movement][:parent_id] = Movement.first.id if Movement.first
    @user = User.create user_params
    @submovement = Movement.new movement_params
    if @submovement.save
      @submovement.users.push(@user)
      sign_in(:user, @user)
      UserMailer.team_creation_message(@user.id, @submovement.id) if current_user
      redirect_to movement_path(@submovement), notice: t('movement.created')
    else
      render :new, notice: t('movement.not_created')
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation)
  end

  def movement_params
    params.require(:movement).permit(:name, :category, :tagline, :call_to_action, :extended_description, :image, :avatar, :video, :about_creator, :website, :flickr, :parent_id, :location, :sponsored)
  end

end
