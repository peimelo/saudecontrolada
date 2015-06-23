require 'rails_helper'

RSpec.describe SiteController, type: :routing do
  describe 'routing' do

    it 'routes to root #index' do
      expect(get: '/').to route_to('site#index')
    end

    it 'does not routes to #show' do
      expect(get: '/site/1').not_to be_routable
    end

    it 'does not routes to #new' do
      expect(get: '/site/new').not_to be_routable
    end

    it 'does not routes to #edit' do
      expect(get: '/site/1/edit').not_to be_routable
    end

    it 'does not routes to #create' do
      expect(post: '/site').not_to be_routable
    end

    it 'does not routes to #update' do
      expect(put: '/site/1').not_to be_routable
    end

    it 'does not routes to #destroy' do
      expect(delete: '/site/1').not_to be_routable
    end
  end
end
