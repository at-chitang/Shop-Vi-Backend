class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    user = User.new(user_create_params)
    user.token = SecureRandom.urlsafe_base64.to_s
    user.create_token_at = Time.now
    if user.save
      UserMailer.register_email(user.email, user.token).deliver_later
      message = { message: 'Create account success!', status: 201 }
    else
      message = { message: user.errors.full_messages, status: 409 }
    end
    render json: message
  end

  def show
    user = current_user
    if user && user == current_user_test
      render json: user, serializer: Users::ShowSerializer
    else
      render json: { message: 'Not found user!', status: 404 }
    end
  end

  def update
    user = current_user
    message = if user
                if user.update(user_update_params)
                  { message: 'Update successed!', status: 202 }
                else
                  { message: 'Update failt!', status: 409 }
                end
              else
                { message: 'Not found user!', status: 404 }
              end
    message['errors'] = user.errors.full_messages
    render json: message
  end

  def destroy
    # User.delete(params[:id])
  end

  private

  def user_create_params
    params.permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end

  def user_update_params
    params.permit(:first_name, :last_name, :phone, :address, :province, :zipcode, :country)
  end
end
