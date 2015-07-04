# == Schema Information
#
# Table name: contatos
#
#  id         :integer          not null, primary key
#  nome       :string(255)
#  email      :string(255)      not null
#  telefones  :string(255)
#  mensagem   :text(65535)      not null
#  ip         :string(255)
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :contato do
    email 'exemplo@exemplo.com'
    mensagem 'Lorem Ipsum is simply dummy text of the printing and typesetting industry.'

    factory :invalid_contato do
      email nil
      mensagem nil
    end
  end
end
