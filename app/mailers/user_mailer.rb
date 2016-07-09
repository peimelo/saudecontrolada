class UserMailer < ApplicationMailer
  def confirmation(user, to_email)
    @user = user
    set_link('confirmations', user.confirmation_token)
    mail to: to_email
  end

  def password(user)
    @user = user
    set_link('passwords', user.reset_password_token)
    mail to: user.email
  end

  private

  def set_link(controller, token)
    @link = "http://#{Rails.application.secrets.mailer_host}/#/#{controller}/#{token}"
  end
end
