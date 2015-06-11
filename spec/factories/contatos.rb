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