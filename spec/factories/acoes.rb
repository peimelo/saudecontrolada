FactoryGirl.define do
  factory :acao do
    sequence(:nome) { Faker::Name.first_name }

    factory :acao_invalida do
      nome nil
    end
  end
end