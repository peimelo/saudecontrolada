FactoryGirl.define do
  factory :acao do
    sequence(:nome) { |n| "acao_#{ n }" }

    factory :acao_invalida do
      nome nil
    end
  end
end