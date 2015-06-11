FactoryGirl.define do
  factory :user do
    date_of_birth { rand(1..100).days.from_now.strftime("%d/%m/%Y") }
    sequence(:email) { Faker::Internet.email }
    gender 'Masculino'
    sequence(:name) { Faker::Name.first_name }
    password 'senha123'
    password_confirmation 'senha123'
    
    factory :user_admin do
      admin true
    end
  end
end
