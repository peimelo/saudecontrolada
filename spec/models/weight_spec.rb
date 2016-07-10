RSpec.describe Weight do
  let(:weight) { create(:weight, user: @user) }
  let(:build_weight) { build(:weight, height: 1.8, value: 70, user: @user) }

  before(:all) do
    @user = create(:user)
  end

  it { expect(build_weight).to be_valid }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:height) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:value) }

    it { should validate_numericality_of(:height).is_greater_than(0.48).is_less_than_or_equal_to(2.5) }
    it { should validate_numericality_of(:value).is_greater_than_or_equal_to(3.35).is_less_than_or_equal_to(400) }
  end

  describe 'scopes' do
    it '.ordered' do
      expect(@user.weight.ordered).to match [weight]
    end
  end

  describe '#imc' do
    it '1,80m e 70Kg deve retornar 21.6' do
      expect(build_weight.imc).to eq 21.6
    end
  end

  describe '#maximum' do
    it '1,80m e 70Kg deve retornar 80.97' do
      expect(build_weight.maximum).to eq 80.97
    end
  end

  describe '#minimum' do
    it '1,80m e 70Kg deve retornar 59.91' do
      expect(build_weight.minimum).to eq 59.91
    end
  end
end
