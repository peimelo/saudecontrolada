# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  provider   :string(255)      not null
#  uid        :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :provider, :uid, :user_id, presence: true
end
