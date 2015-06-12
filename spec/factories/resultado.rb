FactoryGirl.define do
  factory :resultado do
    sequence(:nome) { |n| "resultado_#{n}" }

    factory :invalid_resultado do
      nome nil
    end
  end
end
