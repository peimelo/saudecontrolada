RSpec.describe DashboardController do
  let(:user) { create(:user) }

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
  end

  context 'usuario logado' do
    before :each do
      login_user(user)
    end

    describe 'GET #index' do
      it 'retornar meu imc' do
        create(:peso, altura: 1.8, valor: 70, user: user)
        get :index
        expect(assigns(:meu_imc)).to eq 21.6
      end

      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
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
      it 'nao retornar imc do outro user' do
        create(:peso, user: user, valor: 50)
        get :index
        expect(assigns(:meu_imc)).to_not eq 21.6
      end
    end
  end
end
