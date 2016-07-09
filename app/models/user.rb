class User < ApplicationRecord
  include Confirmable, DatabaseAuthenticatable,
          Recoverable, Comparable

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # attr_accessor :activation_token

  # has_many :authentication, dependent: :delete_all
  has_many :peso, dependent: :delete_all
  has_many :result, dependent: :delete_all

  validates :authentication_token, uniqueness: true, allow_nil: true
  validates :confirmation_token, uniqueness: true, allow_nil: true
  validates :date_of_birth, :gender, :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 8, maximum: 72 }, allow_nil: true
  validate :password_complexity
  validates :reset_password_token, uniqueness: true, allow_nil: true

  before_save { email.downcase! }

  has_secure_password

  delegate :ordered, to: :peso, prefix: true

  scope :ordered, lambda {
    select(:id,
           :created_at,
           :current_sign_in_at,
           :email,
           :last_sign_in_at,
           :name,
           :sign_in_count)
      .order(current_sign_in_at: :desc)
  }

  private

  def password_complexity
    return if password.nil?

    unless CheckPasswordComplexityService.new(password).valid?
      errors.add :password, :security
    end
  end
end
