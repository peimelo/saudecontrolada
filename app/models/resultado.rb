class Resultado < ActiveRecord::Base
  # include SearchModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :user

  # scopes --------------------------------------------------------------------------------------
  scope :listar, ->(search=nil, format=nil, page=nil, order='exames.nome ASC, data DESC') {
    select('resultados.exame_id, exames.nome AS nome, COUNT(*) AS total')
    .joins(:exame)
    .where('exames.nome LIKE ?', "%#{ search }%")
    .group('resultados.exame_id, exames.nome')
    .order(order)
    .page(page) if format.nil?
  }

  # validações ------------------------------------------------------------------------------------
  validates :data, :exame_id, :exame_nome, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 },
            unless: Proc.new { |a| a.valor.blank? }

  # methods ---------------------------------------------------------------------------------------
  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end
end
