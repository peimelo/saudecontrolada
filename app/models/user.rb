class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         :omniauthable,
         :recoverable,
         :registerable,
         :rememberable,
         :trackable,
         :validatable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  #  attr_accessible :email, :name, :password, :password_confirmation, :remember_me

  # relacionamentos -------------------------------------------------------------------------------
  has_many :authentication, dependent: :delete_all
  has_many :peso, dependent: :delete_all

  # validações ------------------------------------------------------------------------------------
  validates :date_of_birth, :gender, :name, presence: true

  # methods ---------------------------------------------------------------------------------------
  def self.from_omniauth(auth, current_user)
    authentication = Authentication.where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize
    if authentication.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        #user.password = Devise.friendly_token
        user.email = auth.info.email

        # Set a random password for omniauthenticated users
        user.password, user.password_confirmation = Devise.friendly_token
        user.confirmed_at, user.confirmation_sent_at = Time.now

        auth.provider == 'twitter' ? user.save(validate: false) : user.save
      end
      authentication.user_id = user.id
      authentication.save
    end
    authentication.user
  end

  def self.new_with_session(params, session)
    if session['devise.user_attributes']
      new(session['devise.user_attributes'], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end

  def update_with_password(params={})
    current_password = params.delete(:current_password)
    check_password = true
    if params[:password].blank?
      params.delete(:password)
      if params[:password_confirmation].blank?
        params.delete(:password_confirmation)
        check_password = false
      end
    end
    result = if valid_password?(current_password) || !check_password
               update_attributes(params)
             else
               self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
               self.attributes = params
               false
             end
    clean_up_passwords
    result
  end
end
