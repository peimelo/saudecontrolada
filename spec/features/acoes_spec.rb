require "rails_helper"

feature 'Acao management' do
  background do
    @acao = create(:acao)
    @acao_nome = Faker::Name.name
    @acao_nome2 = Faker::Name.name
    @recurso = create(:recurso)
    entrar create(:user_admin)
  end

  scenario 'CRUD completo' do
    # listar
    click_link I18n.t('acoes.menu')
    expect(current_path).to eq acoes_path
    expect(page).to have_content @acao.nome
    # listar pesquisando
    fill_in 'search', with: @acao.nome
    click_button 'find'
    expect(page).to have_content @acao.nome

    # incluir
    click_link I18n.t('links.incluir')
    # com valores inválidos
    expect{
      fill_in Acao.human_attribute_name(:nome), with: nil
      click_button I18n.t('links.salvar')
    }.to_not change(Acao, :count)
    # com valores válidos
    expect{
      fill_in Acao.human_attribute_name(:nome), with: @acao_nome
      click_button I18n.t('links.salvar')
    }.to change(Acao, :count).by(1)
    expect(page).to have_content I18n.t('mensagens.flash.create', crud: Acao.model_name.human)
    expect(page).to have_content @acao_nome

    # alterar
    click_link "#{ I18n.t('links.alterar') }_#{ @acao.id }"
    # com valores inválidos
    expect{
      fill_in Acao.human_attribute_name(:nome), with: nil
      click_button I18n.t('links.salvar')
    }.to change(Acao, :count).by(0)
    # com valores válidos
    expect{
      fill_in Acao.human_attribute_name(:nome), with: @acao_nome2
      click_button I18n.t('links.salvar')
    }.to change(Acao, :count).by(0)
    expect(page).to have_content I18n.t('mensagens.flash.update', crud: Acao.model_name.human)
    expect(page).to have_content @acao_nome2

    # excluir
    # com recurso associado
    expect{
      page.driver.submit :delete, "/acoes/#{ @recurso.acao.id }", {}
    }.to change(Acao,:count).by(0)
    # sem tabelas dependentes
    expect{
      page.driver.submit :delete, "/acoes/#{ @acao.id }", {}
    }.to change(Acao,:count).by(-1)
    expect(page).to have_content I18n.t('mensagens.flash.destroy', crud: Acao.model_name.human)
    expect(page).to_not have_content @acao.nome
    #save_and_open_page

    # excel
    click_link I18n.t('links.excel')
  end
end
