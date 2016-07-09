RSpec.describe Api::V1::PasswordsController do
  describe 'routing' do

    it 'does not routes to #index' do
      expect(get: 'api/passwords').not_to be_routable
    end

    it 'does not routes to #show' do
      expect(get: 'api/passwords/0').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: 'api/passwords/new').not_to be_routable
    end

    it 'does not routes to #edit' do
      expect(get: 'api/passwords/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'api/passwords').to route_to(
        'api/v1/passwords#create', format: :json
      )
    end

    it 'does not routes to #update' do
      expect(put: 'api/passwords/1').to route_to('api/v1/passwords#update',
        id: '1', format: :json)
    end

    it 'does not routes to #destroy' do
      expect(delete: 'api/passwords/0').not_to be_routable
    end
  end
end
