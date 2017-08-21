class Api::V1::ConfirmsController < ApplicationController
  def update
    @user = user_token
    if @user
      if @user.active
        messenger = { messenger: 'User had already confirm', status: 201 }
      elsif Time.now - @user.updated_at < 3.days
        @user.update!(active: Time.now)
        messenger = { messenger: 'Confirm success', status: 200 }
      else
        messenger = { messenger: 'Confirm late than 3 days', status: 501 }
      end
    else
      messenger = { messenger: 'Invalid token', status: 502 }
    end
    render json: messenger
  end

  private

  def user_token
    User.find_by(token: params[:token])
  end
end
