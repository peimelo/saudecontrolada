# == Schema Information
#
# Table name: pesos
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  valor      :decimal(5, 2)    not null
#  altura     :decimal(3, 2)    not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


RSpec.describe Peso do
  let(:peso) { create(:peso, user: @user) }
  let(:build_peso) { build(:peso, altura: 1.8, valor: 70, user: @user) }

  before(:all) do
    @user = create(:user)
  end

  it { expect(build_peso).to be_valid }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:altura) }
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:valor) }

    it { should validate_numericality_of(:altura).is_greater_than(0.48).is_less_than_or_equal_to(2.5) }
    it { should validate_numericality_of(:valor).is_greater_than_or_equal_to(3.35).is_less_than_or_equal_to(400) }
  end

  describe 'scopes' do
    it '.ordered' do
      expect(@user.peso.ordered).to match [peso]
    end
  end

  describe '#imc' do
    it '1,80m e 70Kg deve retornar 21.6' do
      expect(build_peso.imc).to eq 21.6
    end
  end

  describe '#maximum' do
    it '1,80m e 70Kg deve retornar 80.97' do
      expect(build_peso.maximum).to eq 80.97
    end
  end

  describe '#minimum' do
    it '1,80m e 70Kg deve retornar 59.91' do
      expect(build_peso.minimum).to eq 59.91
    end
  end
end
