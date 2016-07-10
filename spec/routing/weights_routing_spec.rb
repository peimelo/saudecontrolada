RSpec.describe Api::V1::WeightsController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'api/weights').to route_to('api/v1/weights#index', format: :json)
    end

    it 'does not routes to #show' do
      expect(get: 'api/weights/0').to route_to('api/v1/weights#show', id: '0', format: :json)
    end

    it 'routes to #new' do
      expect(get: 'api/weights/new').to route_to('api/v1/weights#show', id: 'new', format: :json)
    end

    it 'routes to #edit' do
      expect(get: 'api/weights/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'api/weights').to route_to('api/v1/weights#create', format: :json)
    end

    it 'routes to #update' do
      expect(put: 'api/weights/1').to route_to('api/v1/weights#update', id: '1', format: :json)
    end

    it 'routes to #destroy' do
      expect(delete: 'api/weights/1').to route_to('api/v1/weights#destroy', id: '1', format: :json)
    end
  end
end
