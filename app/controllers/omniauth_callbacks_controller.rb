class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :tem_permissao?

  def all
    user = User.from_omniauth(request.env['omniauth.auth'], current_user)
    if user.persisted?
      flash.notice = t('devise.sessions.signed_in')
      sign_in_and_redirect user
    else
      session['devise.user_attributes'] = user.attributes
      redirect_to new_user_registration_url
    end
  end

  alias_method :facebook, :all
  alias_method :google_oauth2, :all
  alias_method :linkedin, :all
  #alias_method :twitter, :all
end
