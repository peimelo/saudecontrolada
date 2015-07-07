# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)      not null
#  gender                 :string(255)      not null
#  date_of_birth          :date             not null
#  admin                  :boolean          default(FALSE), not null
#

class User < ActiveRecord::Base
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

  has_many :authentication, dependent: :delete_all
  has_many :peso, dependent: :delete_all
  has_many :resultado, dependent: :delete_all

  validates :date_of_birth, :email, :encrypted_password, :gender, :name, presence: true

  scope :listar, -> {
    select(:id, :current_sign_in_at, :email, :sign_in_count, :created_at, :confirmed_at)
      .order(current_sign_in_at: :desc)
  }

  def self.from_omniauth(auth, current_user)
    authentication = Authentication.where(provider: auth['provider'], uid: auth['uid']).first_or_initialize
    if authentication.user.blank?
      user = current_user.nil? ? User.where('email = ?', auth['info']['email']).first : current_user
      if user.blank?
        user = User.new
        user.email = auth['info']['email']
        user.name = auth['info']['name']
        ##user.confirmed_at, user.confirmation_sent_at = Time.now
        # Set a random password for omniauthenticated users
        ##user.password, user.password_confirmation = Devise.friendly_token

        ##user.save


        ##if user.persisted?
          ##authentication.user_id = user.id
          ##authentication.save
        ##else
          # se nao foi persistido pode ser porque nao foi fornecido o email pelo provider
          # entao retiramos a confirmacao para evitar o acesso direto com qualquer email
          # preenchido na tela de novo cadastro para onde sera direcionado daqui pelo omniauth_callbacks_controller
          ##user.confirmed_at, user.confirmation_sent_at = nil
          ##user.password, user.password_confirmation = nil
        ##end
      end

      user
    else
      authentication.user
    end
  end

  def idade
    now = Time.now.utc.to_date
    now.year - self.date_of_birth.year - (self.date_of_birth.to_date.change(year: now.year) > now ? 1 : 0)
  end
=begin
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
=end
end
