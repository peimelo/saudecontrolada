require 'rails_helper'

feature 'Feature Site' do
  context 'as not logged' do
    scenario 'render de site#index' do
      visit '/'

      expect(page).to have_content I18n.t('site.index.texto_principal')
      expect(current_path).to eq root_path
    end
  end
  
  context 'as logged user' do
    scenario 'redirect to dashboard#index' do
      entrar create(:user)
      visit '/'

      expect(current_path).to eq dashboard_index_path
    end
  end  
end
