require 'spec_helper.rb.antigo'

feature 'Teste de integração de Contatos' do
  background do
    @contato = create(:contato)
    @user = create(:user_admin)
    entrar @user
  end

  scenario 'CRUD completo' do
    # incluir
    click_link new_contato_path
    # com valores inválidos
    expect{
      fill_in Contato.human_attribute_name(:email), with: nil
      click_button I18n.t('contatos.new.enviar')
    }.to_not change(Contato, :count)
    # com valores válidos
    expect{
      click_link new_contato_path
      fill_in Contato.human_attribute_name(:email), with: @contato.email
      fill_in Contato.human_attribute_name(:mensagem), with: @contato.mensagem
      click_button I18n.t('contatos.new.enviar')
    }.to change(Contato, :count).by(1)
    expect(page).to have_content I18n.t('mensagens.contato_enviado')

    # listar
    click_link I18n.t('contatos.menu')
    expect(current_path).to eq contatos_path
    expect(page).to have_content @contato.email
    #save_and_open_page
  end
end
