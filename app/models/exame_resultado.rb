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

  validates :exame_id, :valor, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exame_id, uniqueness: { scope: :resultado_id }
  validates :resultado_id, uniqueness: { scope: :exame_id }
end
