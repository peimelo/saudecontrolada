class Meal < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }

  scope :ordered, -> {
    select(:id, :name)
  }
end
