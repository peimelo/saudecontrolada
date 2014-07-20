require 'rails_helper'

RSpec.describe Contato, type: :model do
  let(:contato) { create(:contato) }

  it 'must create a new instance with valid attributes' do
    expect(contato).to be_persisted
  end

  it 'is invalid without a email' do
    expect(Contato.create.errors[:email].any?).to be_truthy
  end  

  it 'is invalid without a mensagem' do
    expect(Contato.create.errors[:mensagem].any?).to be_truthy
  end  

  it 'accepts a correctly-formatted email address' do
    %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp].each do |address|
      expect(build(:contato, email: address)).to be_valid
    end
  end

  it 'rejects an incorrectly-formatted email address' do
    %w[user@foo,com user_at_foo.org example.user@foo.].each do |address|
      expect(build(:contato, email: address)).to_not be_valid
    end
  end
end
