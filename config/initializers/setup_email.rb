ActionMailer::Base.smtp_settings = {
  :address              => 'smtp.gmail.com',
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => Rails.application.secrets.email_user_name,
  :password             => Rails.application.secrets.email_password,
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
