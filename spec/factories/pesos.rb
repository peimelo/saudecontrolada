FactoryGirl.define do
  factory :peso do
    altura 1.80
    data { rand(1..100).days.from_now.strftime("%d/%m/%Y") }
    peso 70
    user

    factory :peso_invalido do
      altura nil
    end
  end
end
