RSpec.describe ButtonHelper do
  it '.botao' do
    %w[Label button primary submit].each do |item|
      expect(helper.botao('Label')).to include(item)
    end
  end

  it '.botao_alterar' do
    unidade = create(:unidade)

    %w[default href id title pencil].each do |item|
      expect(helper.botao_alterar(unidade, edit_unidade_path(unidade), Unidade)).to include(item)
    end
  end

  it '.botao_cancelar' do
    %w[default href Cancelar].each do |item|
      expect(helper.botao_cancelar(root_path)).to include(item)
    end
  end

  it '.botao_excluir' do
    unidade = create(:unidade)

    %w[danger data-method Unidade delete nofollow title Excluir trash].each do |item|
      expect(helper.botao_excluir(unidade, Unidade, { sem_confirmar: true })).to include(item)
    end
  end

  it '.botao_incluir' do
    %w[success data-method get href id title fa-file-o Incluir].each do |item|
      expect(helper.botao_incluir('unidades', Unidade)).to include(item)
    end
  end

  it '.botao_link' do
    %w[primary data-method get href Label].each do |item|
      expect(helper.botao_link('Label', root_path)).to include(item)
    end
  end

  it '.botao_salvar' do
    %w[primary name button type submit fa-check Salvar].each do |item|
      expect(helper.botao_salvar).to include(item)
    end
  end

  it '.botao_visualizar' do
    %w[default href title Visualizar fa-eye].each do |item|
      expect(helper.botao_visualizar(root_path, Unidade)).to include(item)
    end
  end
end
