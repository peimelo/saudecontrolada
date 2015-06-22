FactoryGirl.define do
  factory :user do
    date_of_birth 30.years.ago
    sequence(:email) { |n| "email_#{n}@exemplo.com" }
    gender 'Masculino'
    sequence(:name) { |n| "nome_#{n}" }
    password 'senha123'
    password_confirmation 'senha123'
    
    factory :user_admin do
      admin true
    end
  end
end
