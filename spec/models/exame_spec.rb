RSpec.describe Exame do
  it { expect(build(:exame)).to be_valid }

  describe 'associations' do
    it { should belong_to(:unidade) }
    it { should have_many(:resultado).dependent(:restrict_with_error) }
    it { should have_many(:valor).dependent(:delete_all) }
    it { should accept_nested_attributes_for(:valor).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive }
  end

  describe 'scopes' do
    it { expect(Unidade).to be_respond_to(:listar) }
  end

  describe '#nome_unidade' do
    before :all do
      @exame = create(:exame, nome: 'exame')
    end

    it 'sem unidade' do
      expect(@exame.nome_unidade).to eq 'exame'
    end

    it 'com unidade' do
      @exame.unidade = build(:unidade, nome: 'unidade')
      expect(@exame.nome_unidade).to eq "#{@exame.nome} (#{@exame.unidade.nome})"
    end
  end
end
