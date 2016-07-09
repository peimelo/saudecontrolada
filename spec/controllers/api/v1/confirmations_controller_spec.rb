RSpec.describe Api::V1::ConfirmationsController do
  before(:each) do
    @user = create :not_activate_user
  end

  describe 'PUT #update' do
    context 'when link are correct' do
      before(:each) do
        put :update, params: { id: 0, token: @user.confirmation_token }
        @user.reload
      end

      it 'set user to activated' do
        expect(@user.confirmed?).to be_truthy
      end
    end

    # context 'when email are invalid' do
    #   it 'set user to activated' do
    #     put :update, params: { token: @user.confirmation_token }
    #     @user.reload
    #     expect(@user.confirmed?).to be_falsey
    #   end
    # end

    context 'when token are invalid' do
      it 'set user to activated' do
        put :update, params: { id: 0, token: 'invalid token' }
        @user.reload
        expect(@user.confirmed?).to be_falsey
      end
    end
  end
end
