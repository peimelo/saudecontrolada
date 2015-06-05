FactoryGirl.define do
  factory :controlador do
    sequence(:nome) { |n| "controlador_#{ n }" }

    factory :controlador_invalido do
      nome nil
    end
  end
end
