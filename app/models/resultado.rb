class Resultado < ActiveRecord::Base
  include DateModule

  belongs_to :exame
  belongs_to :user

  validates :data, :exame_id, :exame_nome, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 },
            unless: Proc.new { |a| a.valor.blank? }

  scope :exportar, -> {
    includes(exame: [:unidade, valor: :referencia])
    .ordenado
  }

  scope :listar, -> (
    nome = '',
    data_inicial = '',
    data_final = ''
  ) {
    select('resultados.exame_id, exames.nome AS nome, COUNT(*) AS total')
    .joins(:exame)
    .where('exames.nome LIKE ?', "%#{ nome }%")
    .where('resultados.data >= ?', data_inicial.blank? ? '1000-01-01' : format_date_usa(data_inicial))
    .where('resultados.data <= ?', data_final.blank? ? '9999-12-31' : format_date_usa(data_final))
    .group('resultados.exame_id, exames.nome')
    .ordenado
  }

  scope :ordenado, -> {
    order('exames.nome ASC, data ASC')
  }

  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end
end
