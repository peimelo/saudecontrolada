# == Schema Information
#
# Table name: valores
#
#  id             :integer          not null, primary key
#  sexo           :string(255)
#  idade_inferior :decimal(6, 3)
#  idade_superior :decimal(6, 3)
#  valor_inferior :decimal(10, 2)
#  valor_superior :decimal(10, 2)
#  exame_id       :integer          not null
#  referencia_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#  valido         :boolean          default(TRUE), not null
#

RSpec.describe Valor do
  it { expect(build(:valor)).to be_valid }

  describe 'associations' do
    it { should belong_to(:exame) }
    it { should belong_to(:referencia) }
  end

  describe 'validations' do
    it 'idade_inferior less than or equal to idade_superior' do
      [20, 21].each do |idade_superior|
        expect(build(:valor, idade_inferior: 20, idade_superior: idade_superior)).to be_valid
      end
    end

    it 'idade_superior greater than or equal to idade_inferior' do
      [19, 20].each do |idade_inferior|
        expect(build(:valor, idade_superior: 20, idade_inferior: idade_inferior)).to be_valid
      end
    end

    it 'valor_inferior less than or equal to valor_superior' do
      [20, 21].each do |valor_superior|
        expect(build(:valor, valor_inferior: 20, valor_superior: valor_superior)).to be_valid
      end
    end

    it 'valor_superior greater than or equal to valor_inferior' do
      [19, 20].each do |valor_inferior|
        expect(build(:valor, valor_superior: 20, valor_inferior: valor_inferior)).to be_valid
      end
    end

    it { should validate_numericality_of(:idade_inferior).is_less_than_or_equal_to(199.999) }
    it { should validate_numericality_of(:idade_superior).is_less_than_or_equal_to(199.999) }

    it { should validate_numericality_of(:valor_inferior).is_less_than_or_equal_to(99999999.99) }
    it { should validate_numericality_of(:valor_superior).is_less_than_or_equal_to(99999999.99) }
  end
end
