require 'rails_helper'

RSpec.describe Erro, type: :model do
  let(:erro) { create(:erro) }

  it 'must create a new instance with valid attributes' do
    expect(erro).to be_persisted
  end

  it 'is invalid without a recurso_id' do
    expect(Erro.create.errors[:recurso_id].any?).to be_truthy
  end  
end

=begin
require 'spec_helper.rb.antigo'

describe Erro do
  it 'deve retornar condo_nome' do
    erro = build(:erro, condo: nil)
    expect(erro.condo_nome).to eq ''
    
    erro.condo = build(:condo)
    expect(erro.condo_nome).to eq erro.condo.nome
  end

  it 'deve retornar recurso_nome' do
    erro = build(:erro)
    expect(erro.recurso_nome).to eq "#{erro.recurso.controlador.nome} / #{erro.recurso.erro.nome}"
  end

  it 'deve retornar usuario_email' do
    erro = build(:erro, user: nil)
    expect(erro.usuario_email).to eq ''
    
    erro.user = build(:user)
    expect(erro.usuario_email).to eq erro.user.email
  end
=end
