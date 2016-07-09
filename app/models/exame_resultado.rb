class ExameResultado < ApplicationRecord
  self.table_name = 'exames_resultados'

  belongs_to :exame
  belongs_to :result

  validates :exame_id, :valor, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exame_id, uniqueness: { scope: :resultado_id }
  validates :resultado_id, uniqueness: { scope: :exame_id }
end
