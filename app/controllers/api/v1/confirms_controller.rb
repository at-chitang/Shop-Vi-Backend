class Api::V1::ConfirmsController < ApplicationController
  def update
    user = User.find_by(token_params)
    if user
      if user.confirm_at
        messenger = { messenger: 'User had already confirm', status: 200 }
      elsif Time.now - user.create_token_at < 3.days
        user.update!(confirm_at: Time.now, token: nil)
        messenger = { messenger: 'Confirm success', status: 202 }
      else
        user.update!(token: SecureRandom.urlsafe_base64.to_s)
        UserMailer.register_email(user.email, user.token).deliver_later
        messenger = { messenger: 'Confirm expired', status: 403 }
        user.update!(token: nil)
      end
    else
      messenger = { messenger: 'Invalid token', status: 404 }
    end
    render json: messenger
  end

  private

  def token_params
    params.permit(:token)
  end
end
