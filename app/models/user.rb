class User < ActiveRecord::Base
  include SearchModule

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

  # relacionamentos -------------------------------------------------------------------------------
  has_many :authentication, dependent: :delete_all
  has_many :erro, dependent: :nullify
  has_many :peso, dependent: :delete_all
  has_many :resultado, dependent: :delete_all

  # validações ------------------------------------------------------------------------------------
  validates :date_of_birth, :gender, :name, presence: true

  # methods ---------------------------------------------------------------------------------------
  def self.from_omniauth(auth, current_user)
    authentication = Authentication.where(provider: auth.provider, uid: auth.uid.to_s).first_or_initialize
    if authentication.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        user.email = auth.info.email
        user.name = auth.info.name
        user.confirmed_at, user.confirmation_sent_at = Time.now
        # Set a random password for omniauthenticated users
        user.password, user.password_confirmation = Devise.friendly_token

        user.save

        if user.persisted?
          authentication.user_id = user.id
          authentication.save
        else
          # se nao foi persistido pode ser porque nao foi fornecido o email pelo provider
          # entao retiramos a confirmacao para evitar o acesso direto com qualquer email
          # preenchido na tela de novo cadastro para onde sera direcionado daqui pelo omniauth_callbacks_controller
          user.confirmed_at, user.confirmation_sent_at = nil
          user.password, user.password_confirmation = nil
        end
      end

      user
    else
      authentication.user
    end
  end

  def idade
    if self.date_of_birth
      now = Time.now.utc.to_date
      now.year - self.date_of_birth.year - (self.date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
    else
      nil
    end
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
