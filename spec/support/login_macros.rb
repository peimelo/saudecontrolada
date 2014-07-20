module LoginMacros
  def login_user(usuario)
    # @request.env['devise.mapping'] = Devise.mappings[:user]
    @user = usuario
    @user.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the confirmable module
    sign_in @user

    subject.current_user.inspect    # ALL SPECS FAIL WITHOUT THIS LINE!
#    {'warden.user.administrator.key' => session['warden.user.administrator.key'], :condo_id => @local.condo_id}
  end

  def entrar(user)
    user.confirm!
    visit root_path
    #click_link I18n.t('devise.sessions.new.title')
    visit '/users/sign_in'
    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: 'senha123'
    click_button I18n.t('devise.sessions.new.submit')
  end
end