RSpec.describe ReferenciasController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/referencias').to route_to('referencias#index')
    end

    it 'does not routes to #show' do
      expect(get: '/referencias/1').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/referencias/new').to route_to('referencias#new')
    end

    it 'routes to #edit' do
      expect(get: '/referencias/1/edit').to route_to('referencias#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/referencias').to route_to('referencias#create')
    end

    it 'routes to #update' do
      expect(put: '/referencias/1').to route_to('referencias#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/referencias/1').to route_to('referencias#destroy', id: '1')
    end
  end
end
