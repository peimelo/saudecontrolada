RSpec.describe UsersController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/users').to route_to('users#index')
    end

    it 'does not routes to #show' do
      expect(get: '/users/1').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: '/users/new').not_to be_routable
    end

    it 'does not routes to #edit' do
      expect(get: '/users/1/edit').not_to be_routable
    end

    it 'does not routes to #create' do
      expect(post: '/users').not_to route_to('users#create')
    end

    it 'does not routes to #update' do
      expect(put: '/users/1').not_to be_routable
    end

    it 'does not routes to #destroy' do
      expect(delete: '/users/1').not_to be_routable
    end
  end
end
