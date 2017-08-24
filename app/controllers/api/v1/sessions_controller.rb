class Api::V1::SessionsController < ApplicationController
  # before_action :logged_in?, only: :destroy

  def create
    user = User.find_by(email_params)
    if user && user.authenticate(params[:password])
      if user.confirm_at
        user.update_columns(auth_token: SecureRandom.hex, token: nil)
        render json: user, serializer: Users::UserSerializer
      else
        message = { message: 'Please confirm your acount', status: 405 }
        render json: message
      end
    else
      message = { message: 'Invalid email/password', status: 404 }
      render json: message
    end
  end

  def destroy
    user = current_user
    if user
      user.update_columns(auth_token: nil)
      message = { message: 'You logged out!', status: 200 }
    else
      message = { message: 'Invalid user!', status: 404 }
    end
    render json: message
  end

  private

  def email_params
    params.permit(:email)
  end
end
