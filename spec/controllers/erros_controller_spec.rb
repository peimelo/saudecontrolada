require 'rails_helper'

RSpec.describe ErrosController, type: :controller do
  let!(:erro_status) { create(:erro_status, id: 1) }
  let(:erro) { create(:erro, erro_status_id: erro_status.id) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:erro) }

  let!(:formato_excel_session) { { format: :xls } }
  let(:pesquisar_session) { { erro_status_id: 1 } }

  shared_examples('show error message') do
    describe 'GET #show' do
      context 'standard error' do
        before :each do
          get :show, id: erro
        end

        it 'assigns no permission to @mensagem' do
          expect(assigns(:mensagem)).to eq I18n.t('mensagens.erros.sem_permissao')
        end

        it 'redirects to erros#show' do
          expect(response).to render_template :show
        end
      end

      context 'custom error' do
        before :each do
          session[:temp_msg] = 'erro'
          get :show, id: erro
        end

        it 'assigns custom error to @mensagem' do
          expect(assigns(:mensagem)).to eq 'erro'
        end

        it 'redirects to erros#show' do
          expect(response).to render_template :show
        end
      end
    end
  end

  context 'not logged user access' do
    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to require_login
      end
    end

    it_behaves_like 'show error message'

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: erro
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: erro, erro: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: erro
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

    it_behaves_like 'show error message'

    describe 'GET #edit' do
      it 'redirects to erros#show' do
        get :edit, id: erro
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'PATCH #update' do
      it 'redirects to erros#show' do
        patch :update, id: erro, erro: valid_attributes
        expect(response).to redirect_to assigns(:erro)
      end
    end

    describe 'DELETE #destroy' do
      it 'redirects to erros#show' do
        delete :destroy, id: erro
        expect(response).to redirect_to assigns(:erro)
      end
    end
  end

  context 'logged admin user access' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of erros' do
        get :index
        expect(assigns(:erros)).to match_array [erro]
      end

      it 'search and populates an array of erros' do
        get :index, pesquisar_session
        expect(assigns(:erros)).to match_array [erro]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    it_behaves_like 'show error message'

    describe 'GET #edit' do
      before :each do
        get :edit, id: erro
      end

      it 'assigns the requested erro to @erro' do
        expect(assigns(:erro)).to eq erro
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'PATCH #update' do
      before :each do
        patch :update, id: erro, erro: valid_attributes
      end

      it 'saves @erro' do
        expect(assigns(:erro).save).to be_truthy
      end

      it 'redirects to erros#index' do
        expect(response).to redirect_to erros_url
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        delete :destroy, id: erro
      end

      it 'deletes the erro' do
        expect(Erro.exists?(erro)).to be_falsey
      end

      it 'redirects to erros#index' do
        expect(response).to redirect_to erros_url
      end
    end
  end
end
