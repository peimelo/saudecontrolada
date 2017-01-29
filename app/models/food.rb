class Food < ApplicationRecord
  validates :name,
            presence: true,
            uniqueness: {
              case_sensitive: false, scope: [:measure]
            }
end
