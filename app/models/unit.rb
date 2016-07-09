class Unit < ApplicationRecord
  include Scopes

  has_many :exam, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
