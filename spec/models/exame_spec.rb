RSpec.describe Exame do
  it { expect(build(:exame)).to be_valid }

  describe 'associations' do
    it { should belong_to(:unidade) }
    it { should have_many(:resultado).dependent(:restrict_with_error) }
    it { should have_many(:valor).dependent(:delete_all) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive }
    it { should accept_nested_attributes_for(:valor).allow_destroy(true) }
  end

  describe 'scopes' do
    it { expect(Unidade).to be_respond_to(:listar) }
  end
end
