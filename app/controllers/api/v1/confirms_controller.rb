module Api::V1
  class ConfirmsController < ApplicationController
    def update
      user = User.find_by(token_params)
      if user
        if user.confirm_at
          message = { message: 'User had already confirm', status: 200 }
        elsif Time.now - user.create_token_at < 3.days
          user.update!(confirm_at: Time.now, token: nil)
          message = { message: 'Confirm success', status: 202 }
        else
          user.update!(token: SecureRandom.urlsafe_base64.to_s)
          UserMailer.register_email(user.email, user.token).deliver_later
          message = { message: 'Confirm expired', status: 403 }
        end
      else
        message = { message: 'Invalid token', status: 404 }
      end
      render json: message
    end

    private

    def token_params
      params.permit(:token)
    end
  end
end
