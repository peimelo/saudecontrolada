FactoryGirl.define do
  factory :referencia do
    sequence(:nome) { |n| "referencia_#{n}" }

    factory :invalid_referencia do
      nome nil
    end
  end
end
