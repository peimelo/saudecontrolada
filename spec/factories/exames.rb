FactoryGirl.define do
  factory :exame do
    ancestry ''
    sequence(:nome) { |n| "exame_#{n}" }

    factory :invalid_exame do
      nome nil
    end
  end
end
