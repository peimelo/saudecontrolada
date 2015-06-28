# == Schema Information
#
# Table name: unidades
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :unidade do
    sequence(:nome) { |n| "unidade_#{n}" }

    factory :invalid_unidade do
      nome nil
    end
  end
end
