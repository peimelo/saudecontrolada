FactoryGirl.define do
  factory :recurso_categoria do
    sequence(:nome) { |n| "recurso_categoria_#{ n }" }

    factory :invalid_recurso_categoria do
      nome nil
    end
  end
end
