RSpec.describe GenerateToken do
  it 'generate token size 86' do
    authentication_token = GenerateToken.new.call
    expect(authentication_token.size).to eq 86
  end
end