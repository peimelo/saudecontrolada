class Contact < ApplicationRecord
  validates :name, :message, presence: true

  validates :email, presence: true, length: { maximum: 255 },
            format: { with: User::VALID_EMAIL_REGEX }

  after_commit :send_email,
               on: :create

  private

  def send_email
    ContactMailer.notify_me(self).deliver_later
  end
end
