class UsersSerializer < ActiveModel::Serializer
  attributes :created_at,
             :current_sign_in_at,
             :email,
             :name,
             :sign_in_count
end
