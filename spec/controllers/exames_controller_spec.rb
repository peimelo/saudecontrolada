RSpec.describe ExamesController do
  let(:exame) { create(:exame) }
  let(:resultado) { create(:resultado, exame: exame) }
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:valor) { create(:valor, exame: exame) }

  let(:valid_attributes) { attributes_for(:exame) }
  let(:invalid_attributes) { attributes_for(:invalid_exame) }

  let(:formato_excel_session) { { format: :xlsx } }
  let(:formato_pdf_session) { { format: :pdf } }

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
        post :create, exame: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, exame: valid_attributes
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
        post :create, exame: valid_attributes
        expect(response).to redirect_to root_url
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, exame: valid_attributes
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
      it 'populates an array of exames' do
        exame
        get :index
        expect(assigns(:exames)).to match_array [exame]
      end

      it 'populates an array of exames.nome for autocomplete' do
        exame
        get :index, { term: exame.nome, format: :json }
        expect(assigns(:exames)).to match_array [exame]
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
        exame
        get :index, formato_pdf_session
        expect(response.headers['Content-Type']).to have_content 'application/pdf'
      end
    end

    describe 'GET #new' do
      before :each do
        get :new
      end

      it 'assigns a new Exame to @exame' do
        expect(assigns(:exame)).to be_a_new(Exame)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, { id: exame }
      end

      it 'assigns the requested exame to @exame' do
        expect(assigns(:exame)).to eq exame
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, { exame: valid_attributes }
        end

        it 'creates a new exame' do
          expect(Exame.exists?(assigns[:exame].id)).to be_truthy
        end

        it 'redirects to exames#index' do
          expect(response).to redirect_to exames_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, { exame: invalid_attributes }
        end

        it 'does not save the new exame' do
          expect(Exame.exists?(assigns[:exame].id)).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          put :update, id: exame, exame: valid_attributes
        end

        it 'saves @exame' do
          expect(assigns(:exame).save).to be_truthy
        end

        it 'redirects to exames#index' do
          expect(response).to redirect_to exames_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: exame, exame: invalid_attributes
        end

        it 'locates the requested @exame' do
          expect(assigns(:exame)).to eq exame
        end

        it 'does not saves @exame' do
          expect(assigns(:exame).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      context 'with dependent Resultado' do
        it 'not deletes' do
          resultado
          delete :destroy, { id: exame }
          expect(Exame.exists?(exame.id)).to be_truthy
        end
      end

      context 'with dependent Valor' do
        it 'deletes exame and valor' do
          valor
          delete :destroy, { id: exame }
          expect(Valor.exists?(valor.id)).to be_falsey
        end
      end

      context 'without dependent tables' do
        before :each do
          delete :destroy, { id: exame }
        end

        it 'deletes the exame' do
          expect(Exame.exists?(exame.id)).to be_falsey
        end

        it 'redirects to exames#index' do
          expect(response).to redirect_to exames_url
        end
      end
    end
  end
end
