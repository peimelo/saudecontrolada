class Referencia < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  has_many :valor, dependent: :nullify

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
