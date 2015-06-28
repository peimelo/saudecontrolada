# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)      not null
#  gender                 :string(255)
#  date_of_birth          :date
#  admin                  :boolean          default(FALSE), not null
#

FactoryGirl.define do
  factory :user do
    date_of_birth 30.years.ago
    sequence(:email) { |n| "email_#{n}@exemplo.com" }
    gender 'Masculino'
    sequence(:name) { |n| "nome_#{n}" }
    password 'senha123'
    password_confirmation 'senha123'
    
    factory :user_admin do
      admin true
    end
  end
end
