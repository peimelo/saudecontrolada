require 'rails_helper'

RSpec.describe Erro, type: :model do
  let!(:erro) { create(:erro, erro_status: create(:erro_status, id: 2)) }
  let(:condo) { create(:condo) }
  let(:user) { create(:user) }

  it 'must create a new instance with valid attributes' do
    expect(erro).to be_persisted
  end

  it 'is invalid without a recurso_id' do
    expect(Erro.create.errors[:recurso_id].any?).to be_truthy
  end

  describe '#listar' do
    it 'must return all records' do
      expect(Erro.listar(1)).to match_array [erro]
    end
  end

  describe '#listar_por_status' do
    it 'must return all records per status' do
      expect(Erro.listar_por_status(2, 1)).to match_array [erro]
    end
  end

  describe '#qtde_erros_por_status' do
    it 'must return all records per status' do
      expect(Erro.qtde_erros_por_status[0].erro_status_id).to eq 2
    end
  end

  describe '.recurso_nome' do
    it 'must return os nomes de controlador e acao' do
      expect(erro.recurso_nome).to eq "#{erro.recurso.controlador.nome} / #{erro.recurso.acao.nome}"
    end
  end

  context '.usuario_email' do
    describe 'without user' do
      it "must return ''" do
        expect(erro.usuario_email).to eq ''
      end
    end

    describe 'with user' do
      it 'must return condo.nome' do
        erro.user = user

        expect(erro.usuario_email).to eq user.email
      end
    end
  end
end
