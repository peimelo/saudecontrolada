RSpec.describe Contato do
  it { expect(build(:contato)).to be_valid }

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:mensagem) }
  end

  describe 'email format' do
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
