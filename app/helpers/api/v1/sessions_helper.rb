module Api::V1::SessionsHelper
  def current_user
    response.request.env['HTTP_AUTH_TOKEN'] ? User.find_by(auth_token: response.request.env['HTTP_AUTH_TOKEN']) : nil
  end

  def logged_in?
    session[:user_id] != nil
  end
end
