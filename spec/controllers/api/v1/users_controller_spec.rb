RSpec.describe Api::V1::UsersController do

  describe 'GET #index' do
    context 'admin user' do
      before(:each) do
        @user = create :user_admin, authentication_token: GenerateToken.new.call
        api_authorization_header @user.authentication_token
        get :index
      end

      it 'returns the users' do
        expect(json_response[:users][0][:email]).to eql @user.email
      end

      it { expect(response).to be_success }
    end

    context 'not admin user' do
      before(:each) do
        @user = create :user, authentication_token: GenerateToken.new.call
        api_authorization_header @user.authentication_token
        get :index
      end

      it 'renders the json errors' do
        expect(json_response[:errors]).to eq I18n.t('failure.unauthorized')
      end

      it { expect(response.status).to eq 403 }
    end
  end

  describe 'GET #show' do
    context 'find by token' do
      before(:each) do
        @user = create :user, authentication_token: GenerateToken.new.call
        api_authorization_header @user.authentication_token
        get :show, params: { id: 0 }
      end

      it 'returns the user' do
        expect(json_response[:email]).to eql @user.email
      end

      it { expect(response).to be_success }
    end

    context 'not authenticated' do
      before(:each) do
        @user = create :user
        api_authorization_header 'no token'
        get :show, params: { id: 0 }
      end

      it 'renders the json errors' do
        expect(json_response[:errors]).to eq I18n.t('failure.unauthenticated')
      end

      it { expect(response.status).to eq 401 }
    end
  end

  describe 'POST #create' do
    context 'when is successfully created' do
      before(:each) do
        @user_attributes = attributes_for :user
        post :create, params: { user: @user_attributes }
      end

      it 'renders the json representation for the message just created but not confirmed' do
        expect(json_response[:message]).to eq I18n.t('users.create.message')
        expect(json_response[:title]).to eq I18n.t('users.create.title')
      end

      it { expect(response).to be_success }
    end

    context 'when is not created' do
      before(:each) do
        post :create, params: { user: attributes_for(:invalid_user) }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:name)
      end

      it 'renders the json errors on why the user could not be created' do
        expect(json_response[:name]).to include I18n.t('errors.messages.blank')
      end

      it { expect(response).to be_unprocessable }
    end

    context 'try be an admin user' do
      before(:each) do
        post :create, params: { user: attributes_for(:user_admin) }
      end

      it 'created user without admin privilege' do
        expect(assigns(:user).admin).to be_falsey
      end
    end
  end

  describe 'PUT/PATCH #update' do
    before(:each) do
      @user = create :user, authentication_token: GenerateToken.new.call
      api_authorization_header @user.authentication_token
    end

    context 'when is successfully updated' do
      before(:each) do
        @user_attributes = { email: 'another@email.com', name: 'New Name', current_password: @user.password }
        patch :update, params: { id: @user, user: @user_attributes }
      end

      it 'email continuos the same' do
        expect(json_response[:user][:email]).to eql @user.email
        expect(json_response[:user][:unconfirmed_email]).to eql @user_attributes[:email]
      end

      it 'renders the json representation for the updated user' do
        expect(json_response[:user][:name]).to eql @user_attributes[:name]
      end

      it { expect(response).to be_success }
    end

    context 'when is not updated' do
      before(:each) do
        patch :update, params: { id: @user,
                         user: attributes_for(:invalid_user, current_password: @user.password) }
      end

      it 'renders an errors json' do
        expect(json_response).to have_key(:name)
      end

      it 'renders the json errors on the user name can\'t be blank' do
        expect(json_response[:name]).to include I18n.t('errors.messages.blank')
      end

      it { expect(response).to be_unprocessable }
    end

    context 'not authenticated' do
      before(:each) do
        # @user = create :user
        api_authorization_header 'no token'
        get :show, params: { id: 0 }
      end

      it 'renders the json errors' do
        expect(json_response[:errors]).to eq I18n.t('failure.unauthenticated')
      end

      it { expect(response.status).to eq 401 }
    end
  end

  describe 'DELETE #destroy' do
    context 'authenticated' do
      before(:each) do
        @user = create :user, authentication_token: GenerateToken.new.call
        api_authorization_header @user.authentication_token
        delete :destroy, params: { id: 0 }
      end

      it { should respond_with 200 }
    end

    context 'not authenticated' do
      before(:each) do
        @user = create :user
        api_authorization_header 'no token'
        get :destroy, params: { id: 0 }
      end

      it 'renders the json errors' do
        expect(json_response[:errors]).to eq I18n.t('failure.unauthenticated')
      end

      it { expect(response.status).to eq 401 }
    end
  end
end
