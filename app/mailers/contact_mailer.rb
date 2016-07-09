class ContactMailer < ApplicationMailer
  def notify_me(contact)
    @contact = contact
    mail to: Rails.application.secrets.email_username
  end
end
