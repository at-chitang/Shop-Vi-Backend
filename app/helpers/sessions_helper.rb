module SessionsHelper
  def login_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= Manager.find_by id: session[:user_id]
  end

  def logout_user
    session.delete(:user_id)
    @current_user = nil
  end

  def logged_in?
    if current_user.nil?
      flash[:warning] = 'You must login first!'
      redirect_to admin_login_url
    end
    !current_user.nil?
  end
end
