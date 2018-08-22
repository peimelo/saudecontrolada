class User < ApplicationRecord
  include Confirmable, DatabaseAuthenticatable,
          Recoverable, Comparable
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable
  # devise :database_authenticatable, :registerable,
  #         :recoverable, :rememberable, :trackable, :validatable,
  #         :confirmable, :omniauthable
  # include DeviseTokenAuth::Concerns::User

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :alimentation, dependent: :destroy
  has_many :result, dependent: :destroy
  has_many :weight, dependent: :delete_all

  validates :authentication_token, uniqueness: true, allow_nil: true
  validates :confirmation_token, uniqueness: true, allow_nil: true
  validates :date_of_birth, :gender, :name, presence: true
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :gender, inclusion: { in: %w(F M) }
  validates :password, length: { minimum: 8, maximum: 72 }, allow_nil: true
  validate :password_complexity
  validates :reset_password_token, uniqueness: true, allow_nil: true

  before_save { email.downcase! }

  has_secure_password

  delegate :recent_height, to: :weight
  delegate :ordered, to: :alimentation, prefix: true
  delegate :ordered, to: :weight, prefix: true

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

  def age
    if self.date_of_birth
      now = Time.now.utc.to_date
      now.year - self.date_of_birth.year - (self.date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
    else
      nil
    end
  end

  # Override devise_token_auth for use UserSerializer
  # def token_validation_response
  #   UserSerializer.new( self, root: false ).as_json
  # end

  private

  def password_complexity
    return if password.nil?

    unless CheckPasswordComplexityService.new(password).valid?
      errors.add :password, :security
    end
  end
end
