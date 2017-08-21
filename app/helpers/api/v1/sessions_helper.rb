module Api::V1::SessionsHelper
  def current_user
    @current_user = User.find_by(auth_token: response.request.env['HTTP_AUTH_TOKEN'])
  end

  def logged_in?
    session[:user_id] != nil
  end
end
