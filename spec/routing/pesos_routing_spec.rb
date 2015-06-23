RSpec.describe PesosController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/pesos').to route_to('pesos#index')
    end

    it 'does not routes to #show' do
      expect(get: '/pesos/1').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/pesos/new').to route_to('pesos#new')
    end

    it 'routes to #edit' do
      expect(get: '/pesos/1/edit').to route_to('pesos#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/pesos').to route_to('pesos#create')
    end

    it 'routes to #update' do
      expect(put: '/pesos/1').to route_to('pesos#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/pesos/1').to route_to('pesos#destroy', id: '1')
    end
  end
end
