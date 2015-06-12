FactoryGirl.define do
  factory :resultado do
    data { rand(1..100).days.from_now.strftime("%d/%m/%Y") }
    exame
    user

    factory :invalid_resultado do
      exame nil
      user nil
    end
  end
end
