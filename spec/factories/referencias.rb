# == Schema Information
#
# Table name: referencias
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :referencia do
    sequence(:nome) { |n| "referencia_#{n}" }

    factory :invalid_referencia do
      nome nil
    end
  end
end
