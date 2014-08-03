class RecursoCategoria < ActiveRecord::Base
  include SearchModule

  self.table_name = 'recursos_categorias'

  # atributos -------------------------------------------------------------------------------------
  attr_accessor :recursos

  # relacionamentos -------------------------------------------------------------------------------
  has_many :recurso, dependent: :restrict_with_error

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
