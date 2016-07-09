RSpec.describe Api::V1::PesosController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: 'api/pesos').to route_to('api/v1/pesos#index', format: :json)
    end

    # it 'does not routes to #show' do
    #   expect(get: 'api/pesos/1').to route_to('api/v1/users#show', id: '0', format: :json)
    # end

    # it 'routes to #new' do
    #   expect(get: 'api/pesos/new').to route_to('api/v1/users#show', id: 'new', format: :json)
    # end

    it 'routes to #edit' do
      expect(get: 'api/pesos/1/edit').not_to be_routable
    end

    # it 'routes to #create' do
    #   expect(post: 'api/pesos').to route_to('api/v1/pesos#create')
    # end

    # it 'routes to #update' do
    #   expect(put: 'api/pesos/1').to route_to('api/v1/pesos#update', id: '1')
    # end

    # it 'routes to #destroy' do
    #   expect(delete: 'api/pesos/1').to route_to('api/v1/pesos#destroy', id: '1')
    # end
  end
end
