module Recoverable
  extend ActiveSupport::Concern

  included do
    before_update do
      if (respond_to?(:email_changed?) && email_changed?) || password_digest_changed?
        clear_reset_password_token
      end
    end
  end

  module ClassMethods
    def reset_password_by_token(attributes={})
      token = attributes[:id]

      user = find_or_initialize_by(reset_password_token: token)

      if user.persisted?
        if user.confirmed?
          if user.reset_password_period_valid?
            user.reset_password(attributes[:password], attributes[:password_confirmation])
          else
            user.errors.add(:reset_password_token, I18n.t('passwords.failure.expired'))
          end
        else
          user.errors.add(:reset_password_token, I18n.t('passwords.failure.activated'))
        end
      else
        user.errors.add(:reset_password_token, I18n.t('passwords.failure.token'))
      end

      user
    end

    def send_reset_password_instructions(email)
      email = email.present? && email.downcase
      user = find_or_initialize_by(email: email)

      user.send_reset_password_instructions if user.persisted?
      user
    end
  end

  def reset_password(new_password, new_password_confirmation)
    self.password = new_password
    self.password_confirmation = new_password_confirmation
    save
  end

  def reset_password_period_valid?
    reset_password_sent_at && reset_password_sent_at.utc >= 2.hours.ago.utc
  end

  def send_reset_password_instructions
    generate_reset_password_token
    UserMailer.password(self).deliver_now
  end

  protected

  def clear_reset_password_token
    self.reset_password_token = nil
    self.reset_password_sent_at = nil
  end

  def generate_reset_password_token
    self.reset_password_token = GenerateToken.new.call
    self.reset_password_sent_at = Time.now.utc
    save(validate: false)
  end
end
