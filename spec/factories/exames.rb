FactoryGirl.define do
  factory :exame do
    sequence(:nome) { |n| "exame_#{n}" }

    factory :invalid_exame do
      nome nil
    end
  end
end
