class UsersController < Devise::RegistrationsController

  def show
    @user = User.find(params[:id])
  end

  def new_attendee_user
    @event_id = params[:event]
    @attendance = Attendance.new
    @user = current_user ? current_user : User.new
  end

  def create_attendee_user
    # generated_password = Devise.friendly_token.first(10)
    # @user = User.new(user_params.merge(password: generated_password)) unless current_user
    # @user = current_user ? current_user : User.new(user_params.merge(password: generated_password))
    if current_user
    	@user = current_user
    	@user.update(phone: params[:user][:phone]) if params[:user][:phone]
    	@message = "Thanks for attending!"
    else
   		@generated_password = Devise.friendly_token.first(10)
   		@user = User.new(user_params.merge(password: @generated_password))
   		@message = "Thanks for attending! If you need to login again, we've sent you an email with a temporary password"
    end
    @event_id = params[:user][:event_id]
    @event ||= Event.find(@event_id)

    if @user.save
      sign_in(:user, @user)

      Attendance.create(user: @user, event: @event, point_person: params[:attendance][:point_person])

      flash[:success] = @message

      UserMailer.welcome(@user, @generated_password, @event).deliver if @generated_password

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

  # def check_attendance_record
  # 	unless attendance_exists?
  # 		flash[:error] = "You have already signed up!"
  #     #redirect_to event_path(@event)
  # 	end
  # end

  # def attendance_exists?
  # 	Attendance.find_by(user_id: @user.id, event_id: @event.id).nil?
  # end

end
