class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :admin,
             :authentication_token,
             :date_of_birth,
             :email,
             :gender,
             :height,
             :name,
             :unconfirmed_email

  def id
    0
  end

  def height
    object.recent_height.pluck(:height)[0]
  end
end
