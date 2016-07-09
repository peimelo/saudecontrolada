RSpec.describe Api::V1::SessionsController do
  describe 'routing' do

    it 'does not routes to #index' do
      expect(get: 'api/sessions').not_to be_routable
    end

    it 'does not routes to #show' do
      expect(get: 'api/sessions/0').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: 'api/sessions/new').not_to be_routable
    end

    it 'does not routes to #edit' do
      expect(get: 'api/sessions/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'api/sessions').to route_to('api/v1/sessions#create', format: :json)
    end

    it 'does not routes to #update' do
      expect(put: 'api/sessions/0').not_to be_routable
    end

    it 'routes to #destroy' do
      expect(delete: 'api/sessions/0').not_to be_routable
    end
  end
end
