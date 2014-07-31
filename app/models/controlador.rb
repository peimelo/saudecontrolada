class Controlador < ActiveRecord::Base
  include SearchModule

  # relacionamentos -------------------------------------------------------------------------------
  has_many :recurso, dependent: :restrict_with_error

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
