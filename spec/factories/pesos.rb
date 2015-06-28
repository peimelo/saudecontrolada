# == Schema Information
#
# Table name: pesos
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  peso       :decimal(5, 2)    not null
#  altura     :decimal(3, 2)    not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :peso do
    altura '1,80'
    data { rand(1..100).days.ago.strftime('%d/%m/%Y') }
    peso 70
    user

    factory :invalid_peso do
      altura nil
    end
  end
end
