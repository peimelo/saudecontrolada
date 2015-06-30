FactoryGirl.define do
  factory :peso do
    altura '1,80'
    data { rand(1..100).days.ago.strftime('%d/%m/%Y') }
    valor 70
    user

    factory :invalid_peso do
      altura nil
    end
  end
end
