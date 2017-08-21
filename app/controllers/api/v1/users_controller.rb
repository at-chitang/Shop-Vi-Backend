class Api::V1::UsersController < ApplicationController
  def index
    render json: User.all
  end

  def create
    @user = User.new(user_create)
    # binding.pry
    if @user.valid?
      @user.token = SecureRandom.urlsafe_base64.to_s
      @user.save
      # Confirm.create!(confirms_token: @confirms_token, user_id: @user['id'])
      UserMailer.register_email(@user.email, @user.token).deliver_later
      message = { message: 'Create account success!', status: 200 }
    else
      message = { message: 'Create account fail!', status: 422 }
    end
    render json: message
  end

  def update
    # current_user
    # binding.pry
  end

  def destroy
    # binding.pry
    # User.delete(params[:id])
  end

  private

  def user_create
    params.permit(:email, :password, :first_name, :last_name, :phone, :address, :province, :zipcode, :country)
  end
end
