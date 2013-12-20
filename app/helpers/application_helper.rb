module ApplicationHelper

  def user_name_or_email
    current_user.name || current_user.email
  end
end
