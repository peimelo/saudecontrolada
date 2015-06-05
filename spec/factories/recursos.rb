FactoryGirl.define do
  factory :recurso do
    acao_id { create(:acao).id }
    controlador_id { create(:controlador).id }
    sequence(:nome) { |n| "recurso_#{ n }" }
    recurso_categoria_id { create(:recurso_categoria).id }

    factory :invalid_recurso do
      acao_id nil
      controlador_id nil
      nome nil
      recurso_categoria_id nil
    end
  end
end
