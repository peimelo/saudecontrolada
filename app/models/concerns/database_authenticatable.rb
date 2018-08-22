module DatabaseAuthenticatable
  extend ActiveSupport::Concern

  def clean_up_passwords
    self.password = self.password_confirmation = nil
  end

  def update_with_password(params)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if authenticate(current_password)
               update_attributes(params)
             else
               errors.add(:current_password,
                          I18n.t('users.update.invalid_password'))
               false
             end

    clean_up_passwords
    result
  end
end
