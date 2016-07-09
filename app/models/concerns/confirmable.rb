module Confirmable
  extend ActiveSupport::Concern

  included do
    before_create :generate_confirmation_token, if: :confirmation_required?
    after_commit :send_confirmation_instructions,
                 on: :create,
                 if: :send_confirmation_notification?
    before_update :postpone_email_change_until_confirmation_and_regenerate_confirmation_token,
                  if: :postpone_email_change?
    # after_commit :send_confirmation_instructions,
    #              on: :update,
    #              if: :reconfirmation_required?
  end

  def confirm
    pending_any_confirmation do
      if confirmation_period_expired?
        # TODO: add hour
        self.errors.add(:email, I18n.t('confirmations.failure.expired'))
        return false
      end

      self.confirmed_at = Time.now.utc
      clear_confirmation_token

      saved = if pending_reconfirmation?
                self.email = unconfirmed_email
                self.unconfirmed_email = nil
                save(validate: true)
              else
                save(validate: false)
              end
      saved
    end
  end

  def confirmation_required?
    !confirmed?
  end

  def confirmed?
    !!confirmed_at
  end

  def pending_reconfirmation?
    unconfirmed_email.present?
  end

  def send_confirmation_instructions
    unless confirmation_token.nil?
      generate_confirmation_token!
    end

    email = pending_reconfirmation? ? self.unconfirmed_email : self.email
    UserMailer.confirmation(self, email).deliver_now
  end

  protected

  def clear_confirmation_token
    self.confirmation_token = nil
    self.confirmation_sent_at = nil
  end

  def confirmation_period_expired?
    self.confirmation_sent_at && (Time.now.utc > (self.confirmation_sent_at.utc + 3.days))
  end

  def confirmation_period_valid?
    self.confirmation_sent_at && self.confirmation_sent_at.utc >= 2.hours.ago.utc
  end

  def generate_confirmation_token
    if !self.confirmation_token || confirmation_period_expired?
      self.confirmation_token = GenerateToken.new.call
      self.confirmation_sent_at = Time.now.utc
    end
  end

  def generate_confirmation_token!
    generate_confirmation_token && save(validate: false)
  end

  def pending_any_confirmation
    if (confirmation_required? || pending_reconfirmation?)
      yield
    else
      self.errors.add(:email, I18n.t('confirmations.failure.confirmed'))
      false
    end
  end

  def postpone_email_change?
    email_changed? && self.email.present? && (!unconfirmed_email.nil? || !unconfirmed_email_was)
  end

  def postpone_email_change_until_confirmation_and_regenerate_confirmation_token
    self.unconfirmed_email = self.email
    self.email = self.email_was
    self.confirmation_token = nil
    generate_confirmation_token
    self.send_confirmation_instructions
  end

  def reconfirmation_required?
    self.unconfirmed_email.present?
  end

  def send_confirmation_notification?
    confirmation_required? && self.email.present?
  end

  module ClassMethods
    def confirm_by_token(token)
      user = find_or_initialize_by(confirmation_token: token)

      if user.persisted?
        user.confirm
      else
        user.errors.add(:confirmation_token, I18n.t('confirmations.failure.token'))
      end

      user
    end

    def send_confirmation_instructions(email)
      email = email.present? && email.downcase
      user = find_or_initialize_by(email: email)
      user.send_confirmation_instructions if user.persisted? && user.confirmation_required?
    end
  end
end
