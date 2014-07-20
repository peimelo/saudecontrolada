require 'faker'

FactoryGirl.define do
  factory :contato do
    email Faker::Internet.email
    mensagem Faker::Lorem.paragraph

    factory :contato_invalido do
      email nil
      mensagem nil
    end
  end
end