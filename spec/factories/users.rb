require 'faker'

FactoryGirl.define do
  factory :user do
    sequence(:email) { Faker::Internet.email }
    sequence(:name) { Faker::Name.first_name }
    password 'senha123'
    password_confirmation 'senha123'
    
    factory :user_admin do
      admin true
    end
  end
end
