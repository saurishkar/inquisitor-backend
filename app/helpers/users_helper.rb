module UsersHelper
  def set_user_session
    session[:current_user] = @user.id
    session[:current_user_name] = @user.firstname + ' ' + @user.lastname
  end

  def reset_user_session
    session.delete(:current_user)
    session.delete(:current_user_name)
  end
end
