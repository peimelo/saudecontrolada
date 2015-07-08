# == Schema Information
#
# Table name: resultados
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  descricao  :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

RSpec.describe Resultado do
  it { expect(build(:resultado)).to be_valid }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:exame_resultado).dependent(:delete_all) }
    it { should have_many(:exame).through(:exame_resultado) }
    it { should accept_nested_attributes_for(:exame_resultado).allow_destroy(true) }
  end

  describe 'validations' do
    it { should validate_presence_of(:data) }
    it { should validate_presence_of(:descricao) }
    it { should validate_presence_of(:user_id) }
    # it { should validate_numericality_of(:valor).is_less_than_or_equal_to(99999999.99) }
  end

  describe 'scopes' do
    it '.listar' do
      user = create(:user)
      exame = create(:exame)
      resultado = create(:resultado, user: user)

      expect(user.resultado.listar).to match [resultado]
    end
  end

  it { expect(Resultado).to be_respond_to(:format_date_usa) }
end
