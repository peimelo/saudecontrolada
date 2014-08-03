class Recurso < ActiveRecord::Base
  include SearchModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :acao
  belongs_to :controlador
  belongs_to :recurso_categoria
  has_many :erro, dependent: :restrict_with_error
  has_many :perfil, through: :perfil_recurso
  has_many :perfil_recurso, dependent: :delete_all

  # scopes --------------------------------------------------------------------------------------
  # override por causa dos includes
  scope :listar, ->(search, format, page, order) {
    search(search)
    .includes([:acao, :controlador, :recurso_categoria])
    .order(order)
    .page(page) if format.nil?
  }

  scope :visivel, ->() {
    where(visivel: true).order(:nome)
  }

  # validações ------------------------------------------------------------------------------------
  validates :acao_id, :controlador_id, :recurso_categoria_id, presence: true
  validates :acao_id, uniqueness: { scope: :controlador_id }
  validates :controlador_id, uniqueness: { scope: :acao_id }
  validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
