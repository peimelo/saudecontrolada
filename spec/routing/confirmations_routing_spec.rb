RSpec.describe Api::V1::ConfirmationsController do
  describe 'routing' do

    it 'does not routes to #index' do
      expect(get: 'api/confirmations').not_to be_routable
    end

    it 'does not routes to #show' do
      expect(get: 'api/confirmations/0').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: 'api/confirmations/new').not_to be_routable
    end

    it 'routes to #edit' do
      expect(get: 'api/confirmations/1/edit').not_to be_routable
    end

    it 'routes to #create' do
      expect(post: 'api/confirmations').to route_to('api/v1/confirmations#create', format: :json)
    end

    it 'does not routes to #update' do
      expect(put: 'api/confirmations/1').to route_to(
                                              'api/v1/confirmations#update',
                                              id: '1',
                                              format: :json
                                            )
    end

    it 'does not routes to #destroy' do
      expect(delete: 'api/confirmations/0').not_to be_routable
    end
  end
end
