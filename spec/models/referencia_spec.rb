# == Schema Information
#
# Table name: referencias
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Referencia do
  it { expect(build(:referencia)).to be_valid }

  describe 'associations' do
    it { should have_many(:valor).dependent(:restrict_with_error) }
  end

  describe 'validations' do
    it { should validate_presence_of(:nome) }
    it { should validate_uniqueness_of(:nome).case_insensitive }
  end

  describe 'scopes' do
    it { expect(Referencia).to be_respond_to(:listar) }
  end
end
