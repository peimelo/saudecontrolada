require 'faker'

FactoryGirl.define do
  factory :recurso_categoria, :class => 'RecursoCategoria' do
    sequence(:nome) { Faker::Name.first_name.downcase }

    factory :recurso_categoria_invalida do
      nome nil
    end
  end
end
