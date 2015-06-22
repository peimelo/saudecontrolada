FactoryGirl.define do
  factory :authentication do
    provider 'github'
    uid '123'
    user

    factory :invalid_authentication do
      provider nil
      uid nil
      user nil
    end
  end
end