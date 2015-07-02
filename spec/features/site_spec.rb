feature 'Feature Site' do
  context 'Acessar o site' do
    scenario 'render de site#index' do
      visit '/'

      expect(page).to have_content I18n.t('site.index.texto_principal')
      expect(current_path).to eq root_path
    end
  end
  
  context 'Usuario apos estar logado' do
    scenario 'redirect to dashboard#index' do
      entrar create(:user)
      visit '/'

      expect(current_path).to eq dashboard_index_path
    end
  end  

  context 'Login pelo Facebook' do
    scenario 'usuario ja existente - entra com sucesso' do
      create(:user, email: 'exemplo@exemplo.com')
      mock_auth_hash

      visit '/users/sign_in'
      expect(page).to have_content('Facebook')

      click_link 'Facebook'
      expect(current_path).to eq new_user_session_path
    end

    scenario 'usuario nao existente - vai para registro' do
      mock_auth_hash

      visit '/users/sign_in'

      expect(page).to have_content('Facebook')

      click_link 'Facebook'
      expect(current_path).to eq new_user_registration_path
    end
  end
end
