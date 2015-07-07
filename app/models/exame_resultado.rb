# == Schema Information
#
# Table name: exames_resultados
#
#  id           :integer          not null, primary key
#  valor        :decimal(10, 2)   not null
#  exame_id     :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#  resultado_id :integer          not null
#

class ExameResultado < ActiveRecord::Base
  self.table_name = 'exames_resultados'

  belongs_to :exame
  belongs_to :resultado

  validates :exame_id, :resultado_id, :valor, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exame_id, uniqueness: { scope: :resultado_id }
  validates :resultado_id, uniqueness: { scope: :exame_id }

  scope :exportar, -> {
    includes(exame: [:unidade, valor: :referencia])
    .ordenado_por_nome_data
  }

  scope :listar, -> (exame_id) {
    includes(:exame)
      .where('exame_id = ?', exame_id)
      .ordenado_por_data_desc
  }

  scope :listar_por_total_exame, -> (
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
      .ordenado_por_nome_data
  }

  scope :media_valor_de_exame, -> (exame) {
    where('exame_id = ?', exame.id).average(:valor)
  }

  scope :ordenado_por_data_desc, -> {
    order(data: :desc)
  }

  scope :ordenado_por_nome_data, -> {
    order('exames.nome ASC, data ASC')
  }

  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end
end
