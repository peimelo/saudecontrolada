RSpec.describe Peso do
  it { expect(build(:peso)).to be_valid }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:altura) }
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:peso) }

    it { should validate_numericality_of(:altura).is_greater_than(0.48).is_less_than_or_equal_to(2.5) }
    it { should validate_numericality_of(:peso).is_greater_than_or_equal_to(3.35).is_less_than_or_equal_to(400) }
  end

  describe '#imc' do
    it '1.80m e 70Kg deve retornar 21.6' do
      expect(build(:peso, altura: 1.8, peso: 70).imc).to eq 21.6
    end
  end

  describe '#peso_ideal' do
    it '1.80m e 70Kg deve retornar "59,91 ~ 80,97"' do
      expect(build(:peso, altura: 1.8, peso: 70).peso_ideal).to eq '59,91 ~ 80,97'
    end
  end
end
