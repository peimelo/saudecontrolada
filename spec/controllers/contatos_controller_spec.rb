RSpec.describe ContatosController do
  let(:contato) { create(:contato) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:contato) }
  let(:invalid_attributes) { attributes_for(:invalid_contato) }

  let(:formato_excel_session) { { format: :xls } }

  shared_examples('public access to create a new contato') do
    describe 'GET #new' do
      it 'assigns a new Contato to @contato' do
        get :new
        expect(assigns(:contato)).to be_a_new(Contato)
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, contato: valid_attributes
        end

        it 'get the ip of the request' do
          expect(assigns(:contato).ip).to_not be_nil
        end

        it 'creates a new contato' do
          expect(Contato.exists?(assigns[:contato])).to be_truthy
        end

        it 'redirects to contatos#new' do
          expect(response).to redirect_to new_contato_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, contato: invalid_attributes
        end

        it 'does not save the new contato' do
          expect(Contato.exists?(assigns[:contato])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end
  end
  
  shared_examples('logged user access to create a new contato') do
    describe 'GET #new' do
      it 'get the email of the current user' do
        get :new
        expect(assigns(:contato).email).to_not be_nil
      end
    end
  end


  context 'not logged user access' do
    it_behaves_like 'public access to create a new contato'

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

    it_behaves_like 'public access to create a new contato'
    it_behaves_like 'logged user access to create a new contato'

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

    it_behaves_like 'public access to create a new contato'
    it_behaves_like 'logged user access to create a new contato'
    
    describe 'GET #index' do
      it 'populates an array of contatos' do
        get :index
        expect(assigns(:contatos)).to match_array [contato]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end

      it 'download Excel and response have content in application/xls' do
        get :index, formato_excel_session
        expect(response.headers['Content-Type']).to have_content 'application/xls'
      end
    end
  end
end
