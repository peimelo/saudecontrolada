FactoryGirl.define do
  factory :unidade do
    sequence(:nome) { |n| "unidade_#{n}" }

    factory :invalid_unidade do
      nome nil
    end
  end
end
