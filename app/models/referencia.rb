class Referencia < ActiveRecord::Base
  include SearchModule

  has_many :valor, dependent: :restrict_with_error

  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
