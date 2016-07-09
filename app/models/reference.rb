class Reference < ApplicationRecord
  include Scopes

  has_many :valor, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
