RSpec.describe DashboardController do
  describe 'routing' do

    it 'routes to #index' do
      expect(get: '/dashboard').to route_to('dashboard#index')
    end

    it 'does not routes to #show' do
      expect(get: '/dashboard/1').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: '/dashboard/new').not_to be_routable
    end

    it 'does not routes to #edit' do
      expect(get: '/dashboard/1/edit').not_to be_routable
    end

    it 'does not routes to #create' do
      expect(post: '/dashboard').not_to route_to('dashboard#create')
    end

    it 'does not routes to #update' do
      expect(put: '/dashboard/1').not_to be_routable
    end

    it 'does not routes to #destroy' do
      expect(delete: '/dashboard/1').not_to be_routable
    end
  end
end
