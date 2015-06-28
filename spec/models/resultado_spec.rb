# == Schema Information
#
# Table name: resultados
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  valor      :decimal(10, 2)
#  exame_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Resultado do
  it { expect(build(:resultado)).to be_valid }

  describe 'associations' do
    it { should belong_to(:exame) }
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:exame_id) }
    it { should validate_presence_of(:exame_nome) }
    it { should validate_numericality_of(:valor).is_less_than_or_equal_to(99999999.99) }
  end

  describe 'scopes' do
    it '.exportar' do
      user = create(:user)
      resultado = create(:resultado, user: user)

      expect(user.resultado.exportar).to match [resultado]
    end

    it '.listar' do
      user = create(:user)
      resultado = create(:resultado, user: user)

      expect(user.resultado.listar[0].exame_id).to eq resultado.exame_id
    end
  end

  it { expect(Resultado).to be_respond_to(:format_date_usa) }
end
