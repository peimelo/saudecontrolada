# == Schema Information
#
# Table name: resultados
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  descricao  :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Resultado < ActiveRecord::Base
  include DateModule

  belongs_to :user
  has_many :exame_resultado, dependent: :delete_all
  has_many :exame, through: :exame_resultado
  accepts_nested_attributes_for :exame_resultado, allow_destroy: true, reject_if: :all_blank

  validates :data, :descricao, :user_id, presence: true
  validates :data, uniqueness: { scope: :descricao, case_sensitive: false }
  validates :descricao, uniqueness: { scope: :data }

  scope :exportar, -> {
    includes(exame: [:unidade, valor: :referencia])
    .ordenado_por_nome_data
  }

  scope :listar, -> (
    data_inicial = '',
    data_final = '',
    descricao = ''
  ) {
    select(:id, :data, :descricao)
      .where('data >= ?', data_inicial.blank? ? '1000-01-01' : format_date_usa(data_inicial))
      .where('resultados.data <= ?', data_final.blank? ? '9999-12-31' : format_date_usa(data_final))
      .where('descricao LIKE ?', "%#{ descricao }%")
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
