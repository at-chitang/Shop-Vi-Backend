class Api::V1::ConfirmsController < ApplicationController
  def update
    user = user_token
    if user
      if user.confirm_at
        messenger = { messenger: 'User had already confirm', status: 200 }
      elsif Time.now - user.updated_at < 3.days
        user.update!(confirm_at: Time.now, token: nil)
        messenger = { messenger: 'Confirm success', status: 202 }
      else
        messenger = { messenger: 'Confirm expired', status: 403 }
        user.update!(token: nil)
      end
    else
      messenger = { messenger: 'Invalid token', status: 404 }
    end
    render json: messenger
  end

  private

  def user_token
    User.find_by(token: params[:token])
  end
end
