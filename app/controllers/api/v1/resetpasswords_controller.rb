class Api::V1::ResetpasswordsController < ApplicationController
  def index; end

  def create
    user = User.find_by(user_email_params)
    if user
      if user.confirm_at
        user.update!(token: SecureRandom.urlsafe_base64.to_s, create_token_at: Time.now)
        UserMailer.reset_password_email(user.email, user.token).deliver_later
        message = { message: 'Email sent!', status: 202 }
      else
        message = { message: 'Please confirm your account', status: 405 }
      end
    else
      message = { message: 'Invalid email', status: 400 }
    end
    render json: message
  end

  def show; end

  def update
    user = User.find_by(token: user_token_params[:id])
    if user
      if user.confirm_at
        if check_confirm_password
          user.update(password: user_token_params[:password], token: nil)
          message = { message: 'Reset password successed!', status: 202 }
        else
          message = { message: 'Password not correct!', status: 409 }
        end
      else
        message = { message: 'Please confirm your account', status: 405 }
      end
    else
      message = { message: 'Invalid token!', status: 404 }
    end
    render json: message
  end

  private

  def user_email_params
    params.permit(:email)
  end

  def user_token_params
    params.permit(:id, :password, :password_confirm)
  end

  def check_confirm_password
    user_token_params[:password] && user_token_params[:password] == user_token_params[:password_confirm]
  end
end
