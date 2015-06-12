RSpec.describe Valor do
  it { expect(build(:valor)).to be_valid }

  describe 'associations' do
    it { should belong_to(:exame) }
    it { should belong_to(:referencia) }
  end

  describe 'validations' do
    it { should validate_presence_of(:exame_id) }
=begin
    it do
      subject { create(:valor, idade_inferior: 15, idade_superior: 25) }
      should validate_numericality_of(:idade_inferior).is_less_than_or_equal_to(:idade_superior)
    end

    it { should validate_numericality_of(:peso).is_greater_than_or_equal_to(3.35).is_less_than_or_equal_to(400) }
=end
  end
end
