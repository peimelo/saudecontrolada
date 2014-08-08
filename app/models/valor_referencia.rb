class ValorReferencia < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame

  # validações ------------------------------------------------------------------------------------
  validates :valor_inferior, :valor_superior, presence: true
end
