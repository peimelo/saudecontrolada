class ValorReferencia < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame

  # validações ------------------------------------------------------------------------------------
  # validates :nome, presence: true, uniqueness: { case_sensitive: false }
end
