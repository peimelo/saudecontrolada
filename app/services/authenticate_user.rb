class AuthenticateUser
  attr_reader :email, :password

  def initialize(email, password)
    @email = email.present? && email.downcase
    @password = password
  end

  def call
    user = User.find_or_initialize_by(email: email)

    if user.persisted? && user.authenticate(password)
      if user.confirmed?
        generate_authentication_token_and_update_sign_in_information(user)
      else
        user.errors.add(:authentication_token, I18n.t('sessions.not_activated'))
      end
    else
      user.errors.add(:authentication_token, I18n.t('sessions.invalid'))
    end

    user
  end

  private

  def generate_authentication_token_and_update_sign_in_information(user)
    generate_authentication_token(user)
    update_sign_in_information(user)
    user.save
  end

  protected

  def generate_authentication_token(user)
    user.authentication_token = GenerateToken.new.call
  end

  def update_sign_in_information(user)
    user.last_sign_in_at = user.current_sign_in_at
    user.current_sign_in_at = Time.now.utc
    user.sign_in_count += 1
  end
end
