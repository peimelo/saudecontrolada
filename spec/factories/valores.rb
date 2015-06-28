# == Schema Information
#
# Table name: valores
#
#  id             :integer          not null, primary key
#  sexo           :string(255)
#  idade_inferior :decimal(6, 3)
#  idade_superior :decimal(6, 3)
#  valor_inferior :decimal(10, 2)
#  valor_superior :decimal(10, 2)
#  exame_id       :integer          not null
#  referencia_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#  valido         :boolean          default(TRUE), not null
#

FactoryGirl.define do
  factory :valor do
    exame

    factory :invalid_valor do
      exame nil
    end
  end
end
