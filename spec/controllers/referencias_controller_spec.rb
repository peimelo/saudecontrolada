RSpec.describe ReferenciasController do
  let(:referencia) { create(:referencia) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:valor) { create(:valor, referencia: referencia) }

  let(:valid_attributes) { attributes_for(:referencia) }
  let(:invalid_attributes) { attributes_for(:invalid_referencia) }

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
        post :create, referencia: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, referencia: valid_attributes
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
        post :create, referencia: valid_attributes
        expect(response).to redirect_to root_url
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, referencia: valid_attributes
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
      it 'populates an array of referencias' do
        get :index
        expect(assigns(:referencias).include? referencia).to be_truthy
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

      it 'assigns a new Referencia to @referencia' do
        expect(assigns(:referencia)).to be_a_new(Referencia)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, { id: referencia }
      end

      it 'assigns the requested referencia to @referencia' do
        expect(assigns(:referencia)).to eq referencia
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, { referencia: valid_attributes }
        end

        it 'creates a new referencia' do
          expect(Referencia.exists?(assigns[:referencia])).to be_truthy
        end

        it 'redirects to referencias#edit' do
          expect(response).to redirect_to referencias_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, { referencia: invalid_attributes }
        end

        it 'does not save the new referencia' do
          expect(Referencia.exists?(assigns[:referencia])).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          put :update, id: referencia, referencia: valid_attributes
        end

        it 'saves @referencia' do
          expect(assigns(:referencia).save).to be_truthy
        end

        it 'redirects to referencias#index' do
          expect(response).to redirect_to referencias_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: referencia, referencia: invalid_attributes
        end

        it 'locates the requested @referencia' do
          expect(assigns(:referencia)).to eq referencia
        end

        it 'does not saves @referencia' do
          expect(assigns(:referencia).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent Valor' do
        it 'not deletes' do
          valor
          delete :destroy, { id: referencia }
          expect(Referencia.exists?(referencia)).to be_truthy
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, { id: referencia }
        end

        it 'deletes the referencia' do
          expect(Referencia.exists?(referencia)).to be_falsey
        end

        it 'redirects to referencias#index' do
          expect(response).to redirect_to referencias_url
        end
      end
    end
  end
end
