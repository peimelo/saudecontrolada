# == Schema Information
#
# Table name: contatos
#
#  id         :integer          not null, primary key
#  nome       :string(255)
#  email      :string(255)      not null
#  telefones  :string(255)
#  mensagem   :text(65535)      not null
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

RSpec.describe Contato do
  it { expect(build(:contato)).to be_valid }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mensagem) }

    context 'email format' do
      it 'accepts a correctly-formatted email address' do
        %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
          expect(build(:contato, email: address)).to be_valid
        end
      end

      it 'rejects an incorrectly-formatted email address' do
        %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
          expect(build(:contato, email: address)).to_not be_valid
        end
      end
    end
  end
end
