RSpec.describe OmniauthCallbacksController do
  describe 'routing' do

    context 'GET user_omniauth_authorize' do
      it 'facebook' do
        expect(get: '/users/auth/facebook').to route_to('omniauth_callbacks#passthru', provider: 'facebook')
      end

      it 'github' do
        expect(get: '/users/auth/github').to route_to('omniauth_callbacks#passthru', provider: 'github')
      end

      it 'google_oauth2' do
        expect(get: '/users/auth/google_oauth2').to route_to('omniauth_callbacks#passthru', provider: 'google_oauth2')
      end

      it 'linkedin' do
        expect(get: '/users/auth/linkedin').to route_to('omniauth_callbacks#passthru', provider: 'linkedin')
      end
    end

    context 'POST user_omniauth_authorize' do
      it 'facebook' do
        expect(post: '/users/auth/facebook').to route_to('omniauth_callbacks#passthru', provider: 'facebook')
      end

      it 'github' do
        expect(post: '/users/auth/github').to route_to('omniauth_callbacks#passthru', provider: 'github')
      end

      it 'google_oauth2' do
        expect(post: '/users/auth/google_oauth2').to route_to('omniauth_callbacks#passthru', provider: 'google_oauth2')
      end

      it 'linkedin' do
        expect(post: '/users/auth/linkedin').to route_to('omniauth_callbacks#passthru', provider: 'linkedin')
      end
    end

    context 'GET user_omniauth_callback' do
      it 'facebook' do
        expect(get: '/users/auth/facebook/callback').to route_to('omniauth_callbacks#facebook')
      end

      it 'github' do
        expect(get: '/users/auth/github/callback').to route_to('omniauth_callbacks#github')
      end

      it 'google_oauth2' do
        expect(get: '/users/auth/google_oauth2/callback').to route_to('omniauth_callbacks#google_oauth2')
      end

      it 'linkedin' do
        expect(get: '/users/auth/linkedin/callback').to route_to('omniauth_callbacks#linkedin')
      end
    end

    context 'POST user_omniauth_callback' do
      it 'facebook' do
        expect(post: '/users/auth/facebook/callback').to route_to('omniauth_callbacks#facebook')
      end

      it 'github' do
        expect(post: '/users/auth/github/callback').to route_to('omniauth_callbacks#github')
      end

      it 'google_oauth2' do
        expect(post: '/users/auth/google_oauth2/callback').to route_to('omniauth_callbacks#google_oauth2')
      end

      it 'linkedin' do
        expect(post: '/users/auth/linkedin/callback').to route_to('omniauth_callbacks#linkedin')
      end
    end
  end
end
