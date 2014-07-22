class UsersController < Devise::RegistrationsController

  def show
    @user = User.find(params[:id])
  end

  def attendance_notes
    attendee = User.find params[:attendee_id]
    event = Event.find params[:event_id]
    notes = params[:attendance][:notes]
    attendee.attendance_for(event).update(notes: notes) if notes
    render nothing: true
  end

  def new_attendee_user
    @event = Event.find params[:event]
    @attendance = Attendance.new
    @user = current_user ? current_user : User.new
  end

  def create_attendee_user
    user.update(phone: params[:user][:phone]) if params[:user][:phone]

    @event_id = params[:user][:event_id]
    @event ||= Event.find(@event_id)

    if user.save
      sign_in(:user, user)
      if Attendance.where(user: user, event: @event).empty?
        Attendance.create(user: user, event: @event, point_person: params[:attendance][:point_person])
        flash[:success] = message
        if ENV["RAILS_ENV"] == "production"
          ReminderMailWorker.perform_at((@event.start_time-(60 * 60 * 12)), user.id, @event.id) if @event.start_time
          @generated_password ? WelcomeMailWorker.perform_async(user.id, @generated_password, @event.id) : WelcomeMailWorker.perform_async(user.id, "", @event.id)
        end
      else
        flash[:notice] = t('attendee.already_signed_up')
      end
      redirect_to event_path(@event)
    else
      flash[:notice] = user.errors.full_messages.flatten.join(' ')
      render 'new_attendee_user'
    end
  end

  def check_email
    @user = User.find_by_email(params[:user][:email])

    respond_to do |format|
      format.json {render :json => !@user}
      format.js
    end
  end

  private

  def user
    @user ||= current_user || User.new(user_params.merge(password: generated_password))
  end

  def message
    @message ||=
      if current_user
        t('attendee.thanks_for_signed_in_user')
      else
        t('attendee.thanks_for_nonsigned_in_user')
      end
  end

  def generated_password
    @generated_password ||= Devise.friendly_token.first(10)
  end

  def user_params
    params.require(:user).permit(:email, :name, :surname, :phone, :textable)
  end

end
