require 'spec_helper.rb.antigo'

feature 'Teste de integração de Erros' do
  # background do
  #   @erro_status = create(:erro_status, id: 1)
  #   @erro = create(:erro, erro_status_id: @erro_status.id)
  #   @erro_nome = Faker::Name.name
  #   @condo = create(:condo)
  #   @user = create(:user_admin)
  #   entrar @user
  # end

  scenario 'CRUD completo' do
    @erro_status = create(:erro_status, id: 1)
    @erro = create(:erro, erro_status_id: @erro_status.id)
    @erro_nome = Faker::Name.name
    @condo = create(:condo)
    @user = create(:user_admin)
    entrar @user

    # listar
    click_link I18n.t('erros.menu')
    expect(current_path).to eq erros_path
    expect(page).to have_content @erro.nome
    # listar badge
    # save_and_open_page
    visit '/erros/1/filtrar'
    # expect(current_path).to eq erros_path
    expect(page).to have_content @erro.nome

    # alterar
    click_link "#{ I18n.t('links.alterar') }_#{ @erro.id }"
    # com valores válidos
    expect{
      fill_in Erro.human_attribute_name(:descricao), with: Faker::Name.name
      click_button I18n.t('links.salvar')
    }.to change(Erro, :count).by(0)
    expect(page).to have_content I18n.t('mensagens.flash.update', crud: Erro.model_name.human)
    expect(page).to have_content @Erro_nome2

    # excluir
    expect{
      page.driver.submit :delete, "/erros/#{ @erro.id }", {}
    }.to change(Erro,:count).by(-1)
    expect(page).to have_content I18n.t('mensagens.flash.destroy', crud: Erro.model_name.human)
    expect(page).to_not have_content @erro.recurso_nome
  end

  scenario 'validando show erro' do
    @erro_status = create(:erro_status, id: 1)
    @erro = create(:erro, erro_status_id: @erro_status.id)
    @user = create(:user)
    entrar @user

    # listar
    visit '/erros/123456'
    expect(page).to have_content I18n.t('mensagens.erros.sem_permissao')
    visit '/erros/123456/edit'
    expect(page).to have_content I18n.t('mensagens.erros.sem_permissao')
  end
end
