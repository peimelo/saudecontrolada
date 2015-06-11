RSpec.describe Authentication do
  it { expect(build(:authentication)).to be_valid }

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:provider) }
    it { should validate_presence_of(:uid) }
    it { should validate_presence_of(:user_id) }
  end
end
