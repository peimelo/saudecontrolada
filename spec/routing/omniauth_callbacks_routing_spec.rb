RSpec.describe OmniauthCallbacksController do
  describe 'routing' do

    it '#get user_omniauth_authorize facebook' do
      expect(get: '/users/auth/facebook').to route_to('omniauth_callbacks#passthru', provider: 'facebook')
    end

    it '#get user_omniauth_authorize google_oauth2' do
      expect(get: '/users/auth/google_oauth2').to route_to('omniauth_callbacks#passthru', provider: 'google_oauth2')
    end

    it '#get user_omniauth_authorize linkedin' do
      expect(get: '/users/auth/linkedin').to route_to('omniauth_callbacks#passthru', provider: 'linkedin')
    end
    #----------------------------------------------------------------------------------------------
    it '#post user_omniauth_authorize facebook' do
      expect(post: '/users/auth/facebook').to route_to('omniauth_callbacks#passthru', provider: 'facebook')
    end

    it '#post user_omniauth_authorize google_oauth2' do
      expect(post: '/users/auth/google_oauth2').to route_to('omniauth_callbacks#passthru', provider: 'google_oauth2')
    end

    it '#post user_omniauth_authorize linkedin' do
      expect(post: '/users/auth/linkedin').to route_to('omniauth_callbacks#passthru', provider: 'linkedin')
    end
    #----------------------------------------------------------------------------------------------
    it '#get user_omniauth_callback facebook' do
      expect(get: '/users/auth/facebook/callback').to route_to('omniauth_callbacks#facebook')
    end

    it '#get user_omniauth_callback google_oauth2' do
      expect(get: '/users/auth/google_oauth2/callback').to route_to('omniauth_callbacks#google_oauth2')
    end

    it '#get user_omniauth_callback linkedin' do
      expect(get: '/users/auth/linkedin/callback').to route_to('omniauth_callbacks#linkedin')
    end
    #----------------------------------------------------------------------------------------------
    it '#post user_omniauth_callback facebook' do
      expect(post: '/users/auth/facebook/callback').to route_to('omniauth_callbacks#facebook')
    end

    it '#post user_omniauth_callback google_oauth2' do
      expect(post: '/users/auth/google_oauth2/callback').to route_to('omniauth_callbacks#google_oauth2')
    end

    it '#post user_omniauth_callback linkedin' do
      expect(post: '/users/auth/linkedin/callback').to route_to('omniauth_callbacks#linkedin')
    end
  end
end
