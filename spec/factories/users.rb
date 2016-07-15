FactoryGirl.define do
  factory :user do
    confirmed_at Time.now.utc
    current_sign_in_at 1.days.ago
    date_of_birth 30.years.ago
    sequence(:email) { |n| "email_#{n}@example.com" }
    gender 'M'
    sequence(:name) { |n| "name_#{n}" }
    password 'Password-123'
    password_confirmation 'Password-123'

    factory :invalid_user do
      name nil
    end

    factory :not_activate_user do
      confirmed_at nil
    end

    factory :user_admin do
      admin true
    end
  end
end
