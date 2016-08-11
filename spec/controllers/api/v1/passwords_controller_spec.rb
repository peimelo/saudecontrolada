RSpec.describe Api::V1::PasswordsController do
  describe 'POST #create' do
    before(:each) do
      @user = create :user
    end

    context 'exists email' do
      before(:each) do
        post :create, params: { email: @user.email }
      end

      it 'returns the user record corresponding to the given credentials' do
        expect(json_response[:message]).to eq I18n.t('passwords.create.message')
      end

      it { expect(response).to be_success }
    end

    context 'not exists email' do
      before(:each) do
        post :create, params: { email: 'not_exists@email.com' }
      end

      it 'returns the user record corresponding to the given credentials' do
        expect(json_response[:email][0]).to eq I18n.t('passwords.failure.email_not_found')
      end

      it { expect(response).to be_unprocessable }
    end
  end
end
