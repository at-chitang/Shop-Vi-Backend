class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_create_params)
    user.token = SecureRandom.urlsafe_base64.to_s
    if user.save
      UserMailer.register_email(user.email, user.token).deliver_later
      message = { message: 'Create account success!', status: 201 }
      message['update'] = update(user, false)
    else
      message = { message: user.errors.full_messages, status: 409 }
    end
    render json: message
  end

  def update(user = current_user, update = true)
    # user ||= User.find_by(auth_token: params[:auth_token])
    if user
      user.update(user_update_params)
      message = { message: 'Update successed!', status: 202 }
    else
      message = { message: 'Not found user!', status: 404 }
    end
    render json: message if update
    message
  end

  def destroy
    # User.delete(params[:id])
  end

  private

  def user_create_params
    # params.permit(:email, :password, :first_name, :last_name, :phone, :address, :province, :zipcode, :country)
    params.permit(:email, :password, :password_confirmation)
  end

  def user_update_params
    params.permit(:first_name, :last_name, :phone, :address, :province, :zipcode, :country)
  end
end
