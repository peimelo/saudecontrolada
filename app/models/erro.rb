class Erro < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :recurso
  belongs_to :erro_status
  belongs_to :user

  # validações ------------------------------------------------------------------------------------
  validates :erro_status_id, :recurso_id, presence: true

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