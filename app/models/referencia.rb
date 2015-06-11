class Referencia < ActiveRecord::Base
  include SearchModule

  has_many :valor, dependent: :nullify

  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
