# == Schema Information
#
# Table name: resultados
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  valor      :decimal(10, 2)
#  exame_id   :integer          not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Resultado < ActiveRecord::Base
  include DateModule

  belongs_to :exame
  belongs_to :user

  validates :data, :exame_id, :exame_nome, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 },
            unless: Proc.new { |a| a.valor.blank? }

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
