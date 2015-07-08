FactoryGirl.define do
  factory :exame_resultado do
    exame
    resultado
    valor { rand(0..99999999.99) }

    factory :invalid_exame_resultado do
      valor nil
    end
  end
end
