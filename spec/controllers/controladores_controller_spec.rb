require 'rails_helper'

RSpec.describe ControladoresController, type: :controller do
  let(:controlador) { create(:controlador) }
  let!(:erro_status) { create(:erro_status, id: 1) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:controlador) }
  let(:invalid_attributes) { attributes_for(:controlador_invalido) }

  let!(:formato_excel_session) { { format: :xls } }
  let(:pesquisar_session) { { search: controlador.nome } }

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
        get :edit, id: controlador
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, controlador: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: controlador, controlador: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: controlador
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
        get :edit, id: controlador
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'POST #create' do
      it 'redirects to erros#show' do
        post :create, controlador: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to erros#show' do
        patch :update, id: controlador, controlador: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to erros#show' do
        delete :destroy, id: controlador
        expect(response).to redirect_to assigns(:erro)
      end
    end
  end

  context 'logged admin user access' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of controladores' do
        get :index
        expect(assigns(:controladores)).to match_array [controlador]
      end

      it 'search and populates an array of controladores' do
        get :index, pesquisar_session
        expect(assigns(:controladores)).to match_array [controlador]
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

      it 'assigns a new Controlador to @controlador' do
        expect(assigns(:controlador)).to be_a_new(Controlador)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, id: controlador
      end

      it 'assigns the requested controlador to @controlador' do
        expect(assigns(:controlador)).to eq controlador
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, controlador: valid_attributes
        end

        it 'creates a new controlador' do
          expect(Controlador.exists?(assigns[:controlador])).to be_truthy
        end

        it 'redirects to controladores#index' do
          expect(response).to redirect_to controladores_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, controlador: invalid_attributes
        end

        it 'does not save the new controlador' do
          expect(Controlador.exists?(assigns[:controlador])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          patch :update, id: controlador, controlador: valid_attributes
        end

        it 'saves @controlador' do
          expect(assigns(:controlador).save).to be_truthy
        end

        it 'redirects to controladores#index' do
          expect(response).to redirect_to controladores_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: controlador, controlador: invalid_attributes
        end

        it 'locates the requested @controlador' do
          expect(assigns(:controlador)).to eq controlador
        end

        it 'does not saves @controlador' do
          expect(assigns(:controlador).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent tables' do
        before :each do
          create(:recurso, controlador: controlador)
          delete :destroy, id: controlador
        end

        it 'does not deletes with dependent Recurso'  do
          expect(Controlador.exists?(controlador)).to be_truthy
        end

        it 'redirects to controladores#index' do
          expect(response).to redirect_to controladores_url
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, id: controlador
        end

        it 'deletes the controlador' do
          expect(Controlador.exists?(controlador)).to be_falsey
        end

        it 'redirects to controladores#index' do
          expect(response).to redirect_to controladores_url
        end
      end
    end
  end
end
