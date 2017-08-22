class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_create_params)
    user.token = SecureRandom.urlsafe_base64.to_s
    if user.save
      UserMailer.register_email(user.email, user.token).deliver_later
      # ConfirmsController.new_confirm(user.email, user.token)
      # update
      message = { message: 'Create account success!', status: 201 }
    else
      message = { message: user.errors.full_messages, status: 409 }
    end
    render json: message
  end

  def update
    user = current_user
    user_update_params.each do |i|
      user.update(i)
    end
    binding.pry
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
