RSpec.describe Devise do
  describe 'routing' do

    context 'Sessions' do
      it 'routes to #new_user_session' do
        expect(get: '/users/sign_in').to route_to('devise/sessions#new')
      end

      it 'routes to #user_session' do
        expect(post: '/users/sign_in').to route_to('devise/sessions#create')
      end

      it 'routes to #destroy_user_session' do
        expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
      end
    end

    context 'Passwords' do
      it 'routes to #user_password' do
        expect(post: '/users/password').to route_to('devise/passwords#create')
      end

      it 'routes to #new_user_password' do
        expect(get: '/users/password/new').to route_to('devise/passwords#new')
      end

      it 'routes to #edit_user_password' do
        expect(get: '/users/password/edit').to route_to('devise/passwords#edit')
      end

      it 'routes to #update user_password' do
        expect(put: '/users/password').to route_to('devise/passwords#update')
      end
    end

    context 'Registrations' do
      it 'routes to #cancel_user_registration' do
        expect(get: '/users/cancel').to route_to('devise/registrations#cancel')
      end

      it 'routes to #user_registration' do
        expect(post: '/users').to route_to('devise/registrations#create')
      end

      it 'routes to #new_user_registration' do
        expect(get: '/users/sign_up').to route_to('devise/registrations#new')
      end

      it 'routes to #edit_user_registration' do
        expect(get: '/users/edit').to route_to('devise/registrations#edit')
      end

      it 'routes to #update registrations' do
        expect(put: '/users').to route_to('devise/registrations#update')
      end

      it 'routes to #delete registrations' do
        expect(delete: '/users').to route_to('devise/registrations#destroy')
      end
    end

    context 'Confirmations' do
      it 'routes to #user_confirmation' do
        expect(post: '/users/confirmation').to route_to('devise/confirmations#create')
      end

      it 'routes to #new_user_confirmation' do
        expect(get: '/users/confirmation/new').to route_to('devise/confirmations#new')
      end

      it 'routes to #show user_confirmation' do
        expect(get: '/users/confirmation').to route_to('devise/confirmations#show')
      end
    end

    context 'Unlocks' do
      it 'routes to #user_unlock' do
        expect(post: '/users/unlock').to route_to('devise/unlocks#create')
      end

      it 'routes to #new_user_unlock' do
        expect(get: '/users/unlock/new').to route_to('devise/unlocks#new')
      end

      it 'routes to #get users_unlock' do
        expect(get: '/users/unlock').to route_to('devise/unlocks#show')
      end
    end
  end
end
