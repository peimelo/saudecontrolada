class Valor < ActiveRecord::Base
  SEXO = %w[Feminino Masculino]

  belongs_to :exame
  belongs_to :referencia

  validates :exame_id, presence: true

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
