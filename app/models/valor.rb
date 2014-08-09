class Valor < ActiveRecord::Base
  SEXO = %w[Feminino Masculino]

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :referencia

  # validações ------------------------------------------------------------------------------------
  # validates :valor_inferior, :valor_superior, presence: true
end
