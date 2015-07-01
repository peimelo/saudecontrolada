# == Schema Information
#
# Table name: unidades
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Unidade do
  it { expect(build(:unidade)).to be_valid }

  describe 'associations' do
    it { should have_many(:exame).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive }
  end

  describe 'scopes' do
    it { expect(Unidade).to be_respond_to(:listar) }
  end
end
