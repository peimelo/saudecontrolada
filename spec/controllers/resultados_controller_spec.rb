RSpec.describe ResultadosController do
  let(:user) { create(:user) }
  let(:resultado) { create(:resultado, user: user) }
  let(:exame) { create(:exame) }

  let(:valid_attributes) { attributes_for(:resultado, exame_nome: exame.nome) }
  let(:invalid_attributes) { attributes_for(:invalid_resultado) }

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
        post :create, resultado: valid_attributes
        expect(response).to require_login
      end
    end

    describe 'PATCH #update' do
      it 'requires login' do
        patch :update, id: 1, resultado: valid_attributes
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
      it 'se nao passar parametros para pesquisa retona nulo' do
        get :index
        expect(assigns(:resultados)).to match [resultado]
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end

      it 'download Pdf and response have content in application/pdf' do
        create(:resultado, user: user)

        get :index, formato_pdf_session
        expect(response.headers['Content-Type']).to have_content 'application/pdf'
      end
    end

    describe 'GET #new' do
      before :each do
        get :new
      end

      it 'assigns a new Resultado to @resultado' do
        expect(assigns(:resultado)).to be_a_new(Resultado)
      end

      it 'renders the :new template' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      before :each do
        get :edit, { id: resultado }
      end

      it 'assigns the requested resultado to @resultado' do
        expect(assigns(:resultado)).to eq resultado
      end

      it 'renders the :edit template' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        before :each do
          post :create, { resultado: valid_attributes }
        end

        it 'creates a new resultado' do
          expect(Resultado.exists?(assigns[:resultado].id)).to be_truthy
        end

        it 'redirects to resultados#index' do
          expect(response).to redirect_to resultados_url
        end
      end

      context 'with invalid attributes' do
        before :each do
          post :create, { resultado: invalid_attributes }
        end

        it 'does not save the new resultado' do
          expect(Resultado.exists?(assigns[:resultado].id)).to be_falsey
        end

        it 're-renders the new method' do
          expect(response).to render_template :new
        end
      end
    end

    describe 'PATCH #update' do
      context 'valid attributes' do
        before :each do
          put :update, id: resultado, resultado: valid_attributes
        end

        it 'saves @resultado' do
          expect(assigns(:resultado).save).to be_truthy
        end

        it 'redirects to resultados#show' do
          resultado.reload
          expect(response).to redirect_to resultados_url
        end
      end

      context 'invalid attributes' do
        before :each do
          patch :update, id: resultado, resultado: invalid_attributes
        end

        it 'locates the requested @resultado' do
          expect(assigns(:resultado)).to eq resultado
        end

        it 'does not saves @resultado' do
          expect(assigns(:resultado).save).to be_falsey
        end

        it 're-renders the edit method' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      before :each do
        delete :destroy, { id: resultado }
      end

      it 'deletes the resultado' do
        expect(Resultado.exists?(resultado.id)).to be_falsey
      end

      it 'redirects to resultados#index' do
        expect(response).to redirect_to resultados_url
      end
    end
  end

  context 'usuario logado tentando acessar dados de outro usuario' do
    before :each do
      outro_user = create(:user)
      @resultado_outro_user = create(:resultado, user: outro_user)

      login_user(user)
    end

    describe 'GET #index' do
      it 'nao listar dados do outro user' do
        get :index, { descricao: @resultado_outro_user.descricao }
        expect(assigns(:resultados)[0]).to be_nil
      end
    end

    describe 'GET #edit' do
      it 'mostra tela de erro' do
        get :edit, { id: @resultado_outro_user }
        expect(response).to render_erro
      end
    end

    describe 'PATCH #update' do
      it 'mostra tela de erro' do
        patch :update, id: @resultado_outro_user, resultado: valid_attributes
        expect(response).to render_erro
      end
    end

    describe 'DELETE #destroy' do
      it 'mostra tela de erro' do
        delete :destroy, { id: @resultado_outro_user }
        expect(response).to render_erro
      end
    end
  end
end
