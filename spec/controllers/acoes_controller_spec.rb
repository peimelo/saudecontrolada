require 'rails_helper'

RSpec.describe AcoesController, type: :controller do
  let(:acao) { create(:acao) }
  let!(:erro_status) { create(:erro_status, id: 1) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:acao) }
  let(:invalid_attributes) { attributes_for(:acao_invalida) }

  let!(:formato_excel_session) { { format: :xls } }
  let(:pesquisar_session) { { search: acao.nome } }

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
        get :edit, id: acao
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, acao: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: acao, acao: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: acao
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
        get :edit, id: acao
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'POST #create' do
      it 'redirects to erros#show' do
        post :create, acao: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to erros#show' do
        patch :update, id: acao, acao: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to erros#show' do
        delete :destroy, id: acao
        expect(response).to redirect_to assigns(:erro)
      end
    end
  end

  context 'logged admin user access' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of acoes' do
        get :index
        expect(assigns(:acoes)).to match_array [acao]
      end

      it 'search and populates an array of acoes' do
        get :index, pesquisar_session
        expect(assigns(:acoes)).to match_array [acao]
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

      it 'assigns a new Acao to @acao' do
        expect(assigns(:acao)).to be_a_new(Acao)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, id: acao
      end

      it 'assigns the requested acao to @acao' do
        expect(assigns(:acao)).to eq acao
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, acao: valid_attributes
        end

        it 'creates a new acao' do
          expect(Acao.exists?(assigns[:acao])).to be_truthy
        end

        it 'redirects to acoes#index' do
          expect(response).to redirect_to acoes_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, acao: invalid_attributes
        end

        it 'does not save the new acao' do
          expect(Acao.exists?(assigns[:acao])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          patch :update, id: acao, acao: valid_attributes
        end

        it 'saves @acao' do
          expect(assigns(:acao).save).to be_truthy
        end

        it 'redirects to acoes#index' do
          expect(response).to redirect_to acoes_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: acao, acao: invalid_attributes
        end

        it 'locates the requested @acao' do
          expect(assigns(:acao)).to eq acao
        end

        it 'does not saves @acao' do
          expect(assigns(:acao).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent tables' do
        before :each do
          create(:recurso, acao: acao)
          delete :destroy, id: acao
        end

        it 'does not deletes with dependent Recurso'  do
          expect(Acao.exists?(acao)).to be_truthy
        end

        it 'redirects to acoes#index' do
          expect(response).to redirect_to acoes_url
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, id: acao
        end

        it 'deletes the acao' do
          expect(Acao.exists?(acao)).to be_falsey
        end

        it 'redirects to acoes#index' do
          expect(response).to redirect_to acoes_url
        end
      end
    end
  end
end
