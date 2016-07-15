FactoryGirl.define do
  factory :weight do
    height 1.8
    date { rand(1..100).days.ago.strftime('%d/%m/%Y %H:%M') }
    value 70
    user

    factory :invalid_weight do
      height nil
    end
  end
end
