# == Schema Information
#
# Table name: valores
#
#  id             :integer          not null, primary key
#  sexo           :string(255)
#  idade_inferior :decimal(6, 3)
#  idade_superior :decimal(6, 3)
#  valor_inferior :decimal(10, 2)
#  valor_superior :decimal(10, 2)
#  exame_id       :integer          not null
#  referencia_id  :integer
#  created_at     :datetime
#  updated_at     :datetime
#  valido         :boolean          default(TRUE), not null
#

class Valor < ActiveRecord::Base
  SEXO = %w[Feminino Masculino]

  belongs_to :exame
  belongs_to :referencia

  validates :valido, presence: true

  validates :idade_inferior, numericality: { less_than_or_equal_to: :idade_superior },
    unless: Proc.new { |a| a.idade_inferior.blank? or a.idade_superior.blank? }

  validates :idade_superior, numericality: { greater_than_or_equal_to: :idade_inferior },
    unless: Proc.new { |a| a.idade_inferior.blank? or a.idade_superior.blank? }

  validates :valor_inferior, numericality: { less_than_or_equal_to: :valor_superior },
    unless: Proc.new { |a| a.valor_inferior.blank? or a.valor_superior.blank? }

  validates :valor_superior, numericality: { greater_than_or_equal_to: :valor_inferior },
    unless: Proc.new { |a| a.valor_inferior.blank? or a.valor_superior.blank? }

  validates :idade_inferior, numericality: { less_than_or_equal_to: 199.999 },
    unless: Proc.new { |a| a.idade_inferior.blank? }
  validates :idade_superior, numericality: { less_than_or_equal_to: 199.999 },
    unless: Proc.new { |a| a.idade_superior.blank? }

  validates :valor_inferior, numericality: { less_than_or_equal_to: 99999999.99 },
    unless: Proc.new { |a| a.valor_inferior.blank? }
  validates :valor_superior, numericality: { less_than_or_equal_to: 99999999.99 },
    unless: Proc.new { |a| a.valor_superior.blank? }
end
