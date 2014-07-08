class Recurso < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :acao
  belongs_to :controlador
  belongs_to :recurso_categoria
  has_many :erro, dependent: :restrict_with_error

  # validações ------------------------------------------------------------------------------------
  validates :acao_id, :controlador_id, :recurso_categoria_id, presence: true
  validates :acao_id, uniqueness: { scope: :controlador_id }
  validates :controlador_id, uniqueness: { scope: :acao_id }
  validates :nome, uniqueness: { case_sensitive: false }

  # métodos ---------------------------------------------------------------------------------------
  def self.active
    where("visivel = ?", true).order(:nome)
  end

  # def obter_recurso(id_recurso)
  #   where('id = ?', "#{id_recurso}")
  # end

  private
    def self.search(search)
      if search
        where('nome LIKE ?', "%#{search}%")
      else
        all
      end
    end
end