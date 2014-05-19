class UsersController < Devise::RegistrationsController

  def show
    @user = User.find(params[:id])
  end

  def new_attendee_user
    @user = User.new
    @event_id = params[:event_id]
  end

  def create_attendee_user
    binding.pry
    generated_password = Devise.friendly_token.first(10)
    @user = User.new(user_params.merge(password: generated_password))
    @event_id = params[:user][:event_id]
    @event ||= Event.find(@event_id)

    if @user.save
      sign_in(:user, @user)

      Attendance.create(user: @user, event: @event)

      flash[:success] = ("Thanks for attending!  If you need to log in again, we've sent you an email with a temporary password")
      
      ##UserMailer.welcome(user, generated_password).deliver
      redirect_to event_path(@event)
    else

      flash[:notice] = @user.errors.full_messages.flatten.join(' ') 
      render 'new_attendee_user'
    end
  end

  private
  def user_params
    params.require(:user).permit(:email, :name, :phone)
  end

end
