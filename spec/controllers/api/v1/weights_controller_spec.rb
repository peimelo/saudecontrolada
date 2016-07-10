RSpec.describe Api::V1::WeightsController do
  describe 'GET #index' do
    before(:each) do
      user = create :user, authentication_token: GenerateToken.new.call
      4.times { create :weight, user: user }

      api_authorization_header user.authentication_token
      get :index, params: { page: 1 }
    end

    it 'returns 4 records from the database' do
      expect(json_response[:weights].size).to eq 4
    end

    it { expect(response).to be_success }
  end

  describe 'User not authenticated' do
    it 'return 401' do
      get :index, params: { user_id: '1' }
      expect(response.status).to eq 401
    end
  end
end
