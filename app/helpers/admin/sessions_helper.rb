module Admin::SessionsHelper
  def current_user
    @current_user ||= Manager.find_by(id: session[:session_id])
  end

  def login_user(user)
    session[:session_id] = user.id
  end

  def logout(_user)
    session[:session_id] = nil
  end
end
