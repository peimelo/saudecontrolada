FactoryGirl.define do
  factory :erro_status do
    sequence(:nome) { Faker::Name.name.downcase + "#{ rand(1000000) }" }
    classe Faker::Name.name
    classe_badge Faker::Name.name
  end
end
