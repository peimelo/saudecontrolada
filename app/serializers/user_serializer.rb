class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :admin,
             :authentication_token,
             :date_of_birth,
             :email,
             :gender,
             :name,
             :unconfirmed_email

  def id
    0
  end
end
