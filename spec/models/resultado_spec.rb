RSpec.describe Resultado do
  it { expect(build(:resultado)).to be_valid }

  describe 'associations' do
    it { should have_many(:exame).dependent(:nullify) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive }
  end

  describe 'scopes' do
    it { expect(Resultado).to be_respond_to(:listar) }
  end
end
