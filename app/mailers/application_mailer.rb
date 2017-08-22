class ApplicationMailer < ActionMailer::Base
  default from: 'support@shopvi.com'
  layout 'mailer'

  def new_confirm(email, token = SecureRandom.urlsafe_base64.to_s)
    UserMailer.register_email(email, token).deliver_later
  end
end
