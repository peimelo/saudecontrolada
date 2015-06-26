RSpec.describe UsersController do
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:formato_excel_session) { { format: :xlsx } }
  let(:formato_pdf_session) { { format: :pdf } }

  context 'not logged user access' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end
  end

  context 'logged user access' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'redirects to root_path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end
  end

  context 'logged admin user access' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of users' do
        get :index
        expect(assigns(:users)).to match_array [user, user_admin]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end

      it 'download Excel and response have content in xlsx format' do
        get :index, formato_excel_session
        expect(response.headers['Content-Type']).to have_content 'application/vnd.openxmlformats-officedocument'
      end

      it 'download Pdf and response have content in application/pdf' do
        get :index, formato_pdf_session
        expect(response.headers['Content-Type']).to have_content 'application/pdf'
      end
    end
  end
end
