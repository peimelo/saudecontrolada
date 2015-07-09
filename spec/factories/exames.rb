# == Schema Information
#
# Table name: exames
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  unidade_id :integer
#  created_at :datetime
#  updated_at :datetime
#  parent_id  :integer
#

FactoryGirl.define do
  factory :exame do
    ancestry ''
    sequence(:nome) { |n| "exame_#{n}" }

    factory :invalid_exame do
      nome nil
    end
  end
end
