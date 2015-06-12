FactoryGirl.define do
  factory :valor do
    exame

    factory :invalid_valor do
      exame nil
    end
  end
end
