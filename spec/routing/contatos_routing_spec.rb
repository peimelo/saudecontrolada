RSpec.describe ContatosController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/contatos').to route_to('contatos#index')
    end

    it 'does not routes to #show' do
      expect(get: '/contatos/1').not_to be_routable
    end

    it 'routes to #new' do
      expect(get: '/contatos/new').to route_to('contatos#new')
    end

    it 'does not routes to #edit' do
      expect(get: '/contatos/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: '/contatos').to route_to('contatos#create')
    end

    it 'does not routes to #update' do
      expect(put: '/contatos/1').not_to be_routable
    end

    it 'does not routes to #destroy' do
      expect(delete: '/contatos/1').not_to be_routable
    end
  end
end
