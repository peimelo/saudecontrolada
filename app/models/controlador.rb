class Controlador < ActiveRecord::Base
  include SearchModule

  # relacionamentos -------------------------------------------------------------------------------
  has_many :recurso, dependent: :restrict_with_error

  # scopes ----------------------------------------------------------------------------------------
  default_scope { order(:nome) }

  scope :listar, ->(search, page, format) {
    search(search)
    
    if format.nil?
      page(page)
    # else 
    #   format seria excel para mostrar todos os registros
    end
  }

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
