class UserMailer < ApplicationMailer
  def register_email(email, link)
    # @user[:confirm_send] = Time.now
    @link1 = "http://172.17.19.156:3000/v1/confirms/#{link}"
    @link2 = "http://0.0.0.0:3000/v1/confirms/#{link}"
    mail(to: email, subject: 'Welcome to Website')
  end
end
