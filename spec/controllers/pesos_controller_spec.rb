RSpec.describe PesosController do
  let(:user) { create(:user) }
  let(:peso) { create(:peso, user: user) }

  let(:valid_attributes) { attributes_for(:peso) }
  let(:invalid_attributes) { attributes_for(:invalid_peso) }

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
        post :create, peso: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, peso: valid_attributes
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

  context 'usuario logado' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'populates an array of pesos' do
        get :index
        expect(assigns(:pesos).include? peso).to be_truthy
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
        peso
        get :index, formato_pdf_session
        expect(response.headers['Content-Type']).to have_content 'application/pdf'
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
        get :edit, { id: peso }
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
          post :create, { peso: valid_attributes }
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
          post :create, { peso: invalid_attributes }
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
          put :update, id: peso, peso: valid_attributes
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
      before :each do
        delete :destroy, { id: peso }
      end

      it 'deletes the peso' do
        expect(Peso.exists?(peso)).to be_falsey
      end

      it 'redirects to pesos#index' do
        expect(response).to redirect_to pesos_url
      end
    end
  end

  context 'usuario logado tentando acessar dados de outro usuario' do
    before :each do
      outro_user = create(:user)
      @peso_outro_user = create(:peso, user: outro_user)

      login_user(user)
    end

    describe 'GET #index' do
      it 'nao listar dados do outro user' do
        get :index
        expect(assigns(:pesos).include? @peso_outro_user).to be_falsey
      end
    end

    describe 'GET #edit' do
      it 'mostra tela de erro' do
        get :edit, { id: @peso_outro_user }
        expect(response).to render_erro
      end
    end

    describe 'PATCH #update' do
      it 'mostra tela de erro' do
        patch :update, id: @peso_outro_user, peso: valid_attributes
        expect(response).to render_erro
      end
    end

    describe 'DELETE #destroy' do
      it 'mostra tela de erro' do
        delete :destroy, { id: @peso_outro_user }
        expect(response).to render_erro
      end
    end
  end
end
