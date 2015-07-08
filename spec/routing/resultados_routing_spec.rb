RSpec.describe ResultadosController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/resultados').to route_to('resultados#index')
    end

    it 'routes to #show' do
      expect(get: '/resultados/1').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/resultados/new').to route_to('resultados#new')
    end

    it 'routes to #new with exame' do
      expect(get: '/resultados/new/exame').to route_to('resultados#new', exame_nome: 'exame')
    end

    it 'routes to #edit' do
      expect(get: '/resultados/1/edit').to route_to('resultados#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/resultados').to route_to('resultados#create')
    end

    it 'routes to #update' do
      expect(put: '/resultados/1').to route_to('resultados#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/resultados/1').to route_to('resultados#destroy', id: '1')
    end
  end
end
