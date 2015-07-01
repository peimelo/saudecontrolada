# == Schema Information
#
# Table name: referencias
#
#  id         :integer          not null, primary key
#  nome       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#

class Referencia < ActiveRecord::Base
  include SearchModule

  has_many :valor, dependent: :restrict_with_error

  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
