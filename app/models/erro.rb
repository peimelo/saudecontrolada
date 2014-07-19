class Erro < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :erro_status
  belongs_to :recurso
  belongs_to :user

  # scopes ----------------------------------------------------------------------------------------
  scope :listar, ->(page) {
    joins(:erro_status, :recurso).
    order('erro_status_id, created_at DESC').
    page(page)
  }

  scope :listar_por_status, ->(erro_status_id, page) {
    joins(:erro_status, :recurso).
    order('erro_status_id, created_at DESC').
    where('erro_status_id = ?', erro_status_id).
    page(page)
  }

  scope :qtde_erros_por_status, -> {
    select('erro_status_id, count(1) as qtde').group('erro_status_id')
  }

  # validações ------------------------------------------------------------------------------------
  validates :recurso_id, presence: true

  # métodos ---------------------------------------------------------------------------------------
  def condo_nome
    self.condo.nil? ? '' : self.condo.nome
  end

  def recurso_nome
    "#{self.recurso.controlador.nome} / #{self.recurso.acao.nome}"
  end

  def usuario_email
    self.user.nil? ? '' : self.user.email
  end
end
