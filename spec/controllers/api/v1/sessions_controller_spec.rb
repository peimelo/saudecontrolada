RSpec.describe Api::V1::SessionsController, type: :controller do
  describe 'POST #create' do
    before(:each) do
      @user = create :user
    end

    context 'when the credentials are correct with account activation' do
      before(:each) do
        credentials = { email: @user.email, password: @user.password }
        post :create, params: credentials
      end

      it 'returns the user record corresponding to the given credentials' do
        @user.reload
        expect(json_response[:name]).to eq @user.name
      end

      it { expect(response).to be_success }
    end

    context 'when the credentials are correct without account activation' do
      before(:each) do
        @user.update_attribute(:confirmed_at, nil)
        credentials = { email: @user.email, password: @user.password }
        post :create, params: credentials
      end

      it 'returns a json with an error' do
        expect(json_response[:authentication_token][0]).to eq I18n.t('sessions.not_activated')
      end

      it { expect(response).to be_unprocessable }
    end

    context 'when the credentials are incorrect' do
      before(:each) do
        credentials = { email: @user.email, password: 'invalidpassword' }
        post :create, params: { login: credentials }
      end

      it 'returns a json with an error' do
        expect(json_response[:authentication_token][0]).to eq I18n.t('sessions.invalid')
      end

      it { expect(response).to be_unprocessable }
    end
  end

  # describe 'DELETE #destroy' do
  #   before(:each) do
  #     @user = create :user
  #     # @user.confirmation_token = User.new_token
  #     @user.save
  #     api_authorization_header @user.confirmation_token
  #     delete :destroy, params: { id: '0' }
  #   end
  #
  #   it 'regenerate user.confirmation_token' do
  #     expect(assigns(:user).confirmation_token).not_to eq @user.confirmation_token
  #   end
  #
  #   it { expect(response).to be_success }
  # end
end
