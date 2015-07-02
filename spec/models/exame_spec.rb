# == Schema Information
#
# Table name: exames
#
#  id             :integer          not null, primary key
#  nome           :string(255)      not null
#  unidade_id     :integer
#  created_at     :datetime
#  updated_at     :datetime
#  ancestry       :string(255)
#  ancestry_depth :integer          default(0)
#

RSpec.describe Exame do
  let(:exame) { create(:exame, nome: 'exame') }

  it { expect(build(:exame)).to be_valid }

  describe 'associations' do
    it { should belong_to(:unidade) }
    it { should have_many(:resultado).dependent(:restrict_with_error) }
    it { should have_many(:valor).dependent(:delete_all) }
    it { should accept_nested_attributes_for(:valor).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive.scoped_to(:ancestry) }
  end

  describe 'scopes' do
    it { expect(Unidade).to be_respond_to(:listar) }
  end

  describe '#nome_unidade' do
    it 'sem unidade' do
      expect(exame.nome_unidade).to eq 'exame'
    end

    it 'com unidade' do
      exame.unidade = build(:unidade, nome: 'unidade')
      expect(exame.nome_unidade).to eq "#{exame.nome} (#{exame.unidade.nome})"
    end
  end

  describe '#valor_referencia_extenso' do
    it 'retorna "" se valor.nil?' do
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq ''
    end

    it 'retorna "sexo masculino"' do
      create(:valor, exame_id: exame.id, sexo: 'Feminino', valido: true)
      create(:valor, exame_id: exame.id, sexo: 'Masculino', valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Sexo: Masculino |'
    end

    it 'retorna "idade inferior e superior"' do
      create(:valor, exame_id: exame.id, idade_inferior: 30, idade_superior: 40, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Idade: 30 ~ 40 anos |'
    end

    it 'retorna "idade inferior"' do
      create(:valor, exame_id: exame.id, idade_inferior: 30, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Idade acima de: 30 anos |'
    end

    it 'retorna "idade superior"' do
      create(:valor, exame_id: exame.id, idade_superior: 30, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Idade abaixo de: 30 anos |'
    end

    it 'retorna "valor inferior e superior"' do
      create(:valor, exame_id: exame.id, valor_inferior: 30, valor_superior: 40, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Valor: 30.0 ~ 40.0 |'
    end

    it 'retorna "valor inferior"' do
      create(:valor, exame_id: exame.id, valor_inferior: 30, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Valor acima de: 30.0 |'
    end

    it 'retorna "valor superior"' do
      create(:valor, exame_id: exame.id, valor_superior: 30, valido: true)
      expect(exame.valor_referencia_extenso(30, 'Masculino')).to eq '| Valor abaixo de: 30.0 |'
    end
  end

  describe 'Module Tree' do
    before :all do
      @exame_filho = create(:exame, nome: 'exame_filho')
      @exame_pai = create(:exame, nome: 'exame_pai')

      @exame_filho.parent = @exame_pai
      @exame_filho.save
    end

    it '.name_for_selects' do
      expect(@exame_filho.name_for_selects).to eq '|--- exame_filho'
    end

    it '.name_for_tree' do
      expect(@exame_filho.name_for_tree).to eq "<span class='tree_1'>exame_filho</span>"
    end

    context '.possible_parents' do
      it 'pai nao pode ter ninguem' do
        expect(@exame_pai.possible_parents).to match []
      end

      it 'filho soh pode ter o pai' do
        expect(@exame_filho.possible_parents).to match [@exame_pai]
      end
    end
  end
end
