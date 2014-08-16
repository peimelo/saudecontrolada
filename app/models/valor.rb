class Valor < ActiveRecord::Base
  SEXO = %w[Feminino Masculino]

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :referencia

  # validações ------------------------------------------------------------------------------------
  validates :idade_inferior, numericality: { less_than_or_equal_to: :idade_superior },
    unless: Proc.new { |a| a.idade_inferior.blank? or a.idade_superior.blank? }
  
  validates :idade_superior, numericality: { greater_than_or_equal_to: :idade_inferior },
    unless: Proc.new { |a| a.idade_inferior.blank? or a.idade_superior.blank? }
  
  validates :valor_inferior, numericality: { less_than_or_equal_to: :valor_superior },
    unless: Proc.new { |a| a.valor_inferior.blank? or a.valor_superior.blank? }
  
  validates :valor_superior, numericality: { greater_than_or_equal_to: :valor_inferior },
    unless: Proc.new { |a| a.valor_inferior.blank? or a.valor_superior.blank? }

  validates :idade_inferior, numericality: { less_than_or_equal_to: 199.999 }
  validates :idade_superior, numericality: { less_than_or_equal_to: 199.999 }

  validates :valor_inferior, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :valor_superior, numericality: { less_than_or_equal_to: 99999999.99 }
end
