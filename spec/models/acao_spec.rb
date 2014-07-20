require 'rails_helper'

RSpec.describe Acao, type: :model do
  let(:acao) { create(:acao) }

  it 'must create a new instance with valid attributes' do
    expect(acao).to be_persisted
  end

  it 'is invalid without a nome' do
    expect(Acao.create.errors[:nome].any?).to be_truthy
  end  

  it 'is invalid with a duplicate nome' do
    expect(Acao.create(attributes_for(:acao, nome: acao.nome)).errors[:nome].any?).to be_truthy
  end

  it 'is invalid with a duplicate nome in upper case' do
    expect(Acao.create(attributes_for(:acao, nome: acao.nome.upcase)).errors[:nome].any?).to be_truthy
  end

  describe '.search' do
    context 'without param' do
      it 'list all records' do
        expect(Acao.search(nil)).to match_array [acao]
      end
    end

    context 'with param' do
      it 'list search records' do
        expect(Acao.search(acao.nome)).to match_array [acao]
      end
    end
  end
end
