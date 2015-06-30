RSpec.describe UnidadesController do
  let(:unidade) { create(:unidade) }
  let(:exame) { create(:exame, unidade:unidade) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }

  let(:valid_attributes) { attributes_for(:unidade) }
  let(:invalid_attributes) { attributes_for(:invalid_unidade) }

  context 'usuario nao logado' do
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
        get :edit, id: 1
        expect(response).to require_login
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, unidade: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, unidade: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: 1
        expect(response).to require_login
      end
    end
  end

  context 'usuario logado sem ser administrador' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'requires login' do
        get :index
        expect(response).to redirect_to root_url
      end
    end

    describe 'GET #new' do
      it 'requires login' do
        get :new
        expect(response).to redirect_to root_url
      end
    end

    describe 'GET #edit' do
      it 'requires login' do
        get :edit, id: 1
        expect(response).to redirect_to root_url
      end
    end

    describe 'POST #create' do
      it 'requires login' do
        post :create, unidade: valid_attributes
        expect(response).to redirect_to root_url
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, unidade: valid_attributes
        expect(response).to redirect_to root_url
      end
    end

    describe 'DELETE #destroy' do
      it 'requires login' do
        delete :destroy, id: 1
        expect(response).to redirect_to root_url
      end
    end
  end

  context 'usuario administrador logado' do
    before :each do
      login_user(user_admin)
    end

    describe 'GET #index' do
      it 'populates an array of unidades' do
        get :index, { search: unidade.nome }
        expect(assigns(:unidades).include? unidade).to be_truthy
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end

    describe 'GET #new' do
      before :each do
        get :new
      end

      it 'assigns a new Unidade to @unidade' do
        expect(assigns(:unidade)).to be_a_new(Unidade)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, { id: unidade }
      end

      it 'assigns the requested unidade to @unidade' do
        expect(assigns(:unidade)).to eq unidade
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, { unidade: valid_attributes }
        end

        it 'creates a new unidade' do
          expect(Unidade.exists?(assigns[:unidade])).to be_truthy
        end

        it 'redirects to unidades#index' do
          expect(response).to redirect_to unidades_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, { unidade: invalid_attributes }
        end

        it 'does not save the new unidade' do
          expect(Unidade.exists?(assigns[:unidade])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          put :update, id: unidade, unidade: valid_attributes
        end

        it 'saves @unidade' do
          expect(assigns(:unidade).save).to be_truthy
        end

        it 'redirects to unidades#index' do
          expect(response).to redirect_to unidades_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: unidade, unidade: invalid_attributes
        end

        it 'locates the requested @unidade' do
          expect(assigns(:unidade)).to eq unidade
        end

        it 'does not saves @unidade' do
          expect(assigns(:unidade).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent Exame' do
        it 'not deletes' do
          exame
          delete :destroy, { id: unidade }
          expect(Unidade.exists?(unidade)).to be_truthy
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, { id: unidade }
        end

        it 'deletes the unidade' do
          expect(Unidade.exists?(unidade)).to be_falsey
        end

        it 'redirects to unidades#index' do
          expect(response).to redirect_to unidades_url
        end
      end
    end
  end
end
