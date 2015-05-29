require 'rails_helper'

RSpec.describe PesosController, type: :controller do
  let(:peso) { create(:peso) }
  let!(:erro_status) { create(:erro_status, id: 1) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:peso) }
  let(:invalid_attributes) { attributes_for(:peso_invalido) }

  let!(:formato_excel_session) { { format: :xls } }
  let(:pesquisar_session) { { search: peso.nome } }

  context 'not logged user access' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to require_login
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: peso
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, peso: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: peso, peso: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: peso
        expect(response).to require_login
      end
    end
  end

  context 'logged user access' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'redirects to erros#show' do
        get :index
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'GET #new' do
      it 'redirects to erros#show' do
        get :new
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'GET #edit' do
      it 'redirects to erros#show' do
        get :edit, id: peso
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'POST #create' do
      it 'redirects to erros#show' do
        post :create, peso: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to erros#show' do
        patch :update, id: peso, peso: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to erros#show' do
        delete :destroy, id: peso
        expect(response).to redirect_to assigns(:erro)
      end
    end
  end

  context 'logged admin user access' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of pesos' do
        get :index
        expect(assigns(:pesos)).to match_array [peso]
      end

      it 'search and populates an array of pesos' do
        get :index, pesquisar_session
        expect(assigns(:pesos)).to match_array [peso]
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

    describe 'GET #new' do
      before :each do
        get :new
      end

      it 'assigns a new Peso to @peso' do
        expect(assigns(:peso)).to be_a_new(Peso)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, id: peso
      end

      it 'assigns the requested peso to @peso' do
        expect(assigns(:peso)).to eq peso
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, peso: valid_attributes
        end

        it 'creates a new peso' do
          expect(Peso.exists?(assigns[:peso])).to be_truthy
        end

        it 'redirects to pesos#index' do
          expect(response).to redirect_to pesos_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, peso: invalid_attributes
        end

        it 'does not save the new peso' do
          expect(Peso.exists?(assigns[:peso])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          patch :update, id: peso, peso: valid_attributes
        end

        it 'saves @peso' do
          expect(assigns(:peso).save).to be_truthy
        end

        it 'redirects to pesos#index' do
          expect(response).to redirect_to pesos_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: peso, peso: invalid_attributes
        end

        it 'locates the requested @peso' do
          expect(assigns(:peso)).to eq peso
        end

        it 'does not saves @peso' do
          expect(assigns(:peso).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent tables' do
        before :each do
          create(:recurso, peso: peso)
          delete :destroy, id: peso
        end

        it 'does not deletes with dependent Recurso'  do
          expect(Peso.exists?(peso)).to be_truthy
        end

        it 'redirects to pesos#index' do
          expect(response).to redirect_to pesos_url
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, id: peso
        end

        it 'deletes the peso' do
          expect(Peso.exists?(peso)).to be_falsey
        end

        it 'redirects to pesos#index' do
          expect(response).to redirect_to pesos_url
        end
      end
    end
  end
end
