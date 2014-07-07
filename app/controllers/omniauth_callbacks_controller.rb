class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :tem_permissao?

  def all
    user = User.from_omniauth(request.env['omniauth.auth'], current_user)
    if user.persisted?
      # flash.notice = t('devise.sessions.signed_in')
      provider = params[:action] == 'google_oauth2' ? 'Google' : params[:action].to_s.titleize
      flash.notice = t('devise.omniauth_callbacks.success', kind: provider)
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

  private

# REDIRECT URIS no https://console.developers.google.com/:
# http://exemplo.com.br/users/auth/google_oauth2/callback
# ativar as APIs:
# Contacts API e Google+ API