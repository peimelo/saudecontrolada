require 'rails_helper'

RSpec.describe SiteController, type: :controller do
  let(:user) { create(:user) }

  context 'public access' do
    describe 'GET #index' do
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
    
  context 'logged user access' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'redirects to dashboard#index' do
        get :index
        expect(response).to redirect_to dashboard_index_url
      end
    end
  end
end
