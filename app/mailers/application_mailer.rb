class ApplicationMailer < ActionMailer::Base
  default from: Rails.application.secrets.mailer_sender
  default reply_to: Rails.application.secrets.email_username
  layout 'mailer'
end
