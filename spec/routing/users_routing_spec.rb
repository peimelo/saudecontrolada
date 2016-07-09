RSpec.describe Api::V1::UsersController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'api/users').to route_to('api/v1/users#index', format: :json)
    end

    it 'routes to #show' do
      expect(get: 'api/users/0').to route_to('api/v1/users#show', id: '0', format: :json)
    end

    it 'does not routes to #new' do
      expect(get: 'api/users/new').to route_to('api/v1/users#show', id: 'new', format: :json)
    end

    it 'does not routes to #edit' do
      expect(get: 'api/users/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'api/users').to route_to('api/v1/users#create', format: :json)
    end

    it 'routes to #update' do
      expect(put: 'api/users/0').to route_to('api/v1/users#update', id: '0', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: 'api/users/0').to route_to('api/v1/users#destroy', id: '0', format: :json)
    end
  end
end
