FactoryGirl.define do
  factory :controlador do
    sequence(:nome) { Faker::Name.first_name }

    factory :controlador_invalido do
      nome nil
    end
  end
end
