require 'rails_helper'

feature 'Teste de integração de Controladores' do
  background do
    @controlador = create(:controlador)
    @controlador_nome = Faker::Name.name
    @controlador_nome2 = Faker::Name.name
    @recurso = create(:recurso)
    @user = create(:user_admin)
    entrar @user
  end

  scenario 'CRUD completo' do
    # listar
    click_link I18n.t('controladores.menu')
    expect(current_path).to eq controladores_path
    expect(page).to have_content @controlador.nome
    # listar pesquisando
    fill_in 'search', with: @controlador.nome
    click_button 'find'
    expect(page).to have_content @controlador.nome

    # incluir
    click_link I18n.t('links.incluir')
    # com valores inválidos
    expect{
      fill_in Controlador.human_attribute_name(:nome), with: nil
      click_button I18n.t('links.salvar')
    }.to_not change(Controlador, :count)
    # com valores válidos
    expect{
      fill_in Controlador.human_attribute_name(:nome), with: @controlador_nome
      click_button I18n.t('links.salvar')
    }.to change(Controlador, :count).by(1)
    expect(page).to have_content I18n.t('mensagens.flash.create', crud: Controlador.model_name.human)
    expect(page).to have_content @controlador_nome

    # alterar
    click_link "#{ I18n.t('links.alterar') }_#{ @controlador.id }"
    # com valores inválidos
    expect{
      fill_in Controlador.human_attribute_name(:nome), with: nil
      click_button I18n.t('links.salvar')
    }.to change(Controlador, :count).by(0)
    # com valores válidos
    expect{
      fill_in Controlador.human_attribute_name(:nome), with: @controlador_nome2
      click_button I18n.t('links.salvar')
    }.to change(Controlador, :count).by(0)
    expect(page).to have_content I18n.t('mensagens.flash.update', crud: Controlador.model_name.human)
    expect(page).to have_content @controlador_nome2

    # excluir
    # com recurso associado
    expect{
      page.driver.submit :delete, "/controladores/#{ @recurso.controlador.id }", {}
    }.to change(Controlador,:count).by(0)
    # sem tabelas dependentes
    expect{
      page.driver.submit :delete, "/controladores/#{ @controlador.id }", {}
    }.to change(Controlador,:count).by(-1)
    expect(page).to have_content I18n.t('mensagens.flash.destroy', crud: Controlador.model_name.human)
    expect(page).to_not have_content @controlador.nome
    #save_and_open_page

    # excel
    click_link I18n.t('links.excel')
  end
end
