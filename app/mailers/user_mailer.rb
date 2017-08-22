class UserMailer < ApplicationMailer
  def register_email(email, token)
    @token = token
    mail(to: email, subject: 'Welcome to Website')
  end

  def reset_password_email(email, token)
    @token = token
    mail(to: email, subject: 'Reset your acount\'s password')
  end
end
