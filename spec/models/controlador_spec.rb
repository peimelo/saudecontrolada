require 'rails_helper'

RSpec.describe Controlador, type: :model do
  let(:controlador) { create(:controlador) }

  it 'must create a new instance with valid attributes' do
    expect(controlador).to be_persisted
  end

  it 'is invalid without a nome' do
    expect(Controlador.create.errors[:nome].any?).to be_truthy
  end  

  it 'is invalid with a duplicate nome' do
    expect(Controlador.create(attributes_for(:controlador, nome: controlador.nome)).errors[:nome].any?).to be_truthy
  end

  it 'is invalid with a duplicate nome in upper case' do
    expect(Controlador.create(attributes_for(:controlador, nome: controlador.nome.upcase)).errors[:nome].any?).to be_truthy
  end

  describe '.search' do
    context 'without param' do
      it 'list all records' do
        expect(Controlador.search(nil)).to match_array [controlador]
      end
    end

    context 'with param' do
      it 'list search records' do
        expect(Controlador.search(controlador.nome)).to match_array [controlador]
      end
    end
  end
end
