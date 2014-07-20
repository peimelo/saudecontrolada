require 'faker'

FactoryGirl.define do
  factory :erro_status do
    sequence(:nome) { Faker::Name.name }
    classe Faker::Name.name
    classe_badge Faker::Name.name
  end
end
