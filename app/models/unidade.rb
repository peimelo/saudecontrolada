class Unidade < ActiveRecord::Base
  include SearchModule
  
  # armazenamento de logs
  has_paper_trail

  # relacionamentos -------------------------------------------------------------------------------
  has_many :exame, dependent: :nullify

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  # methods ---------------------------------------------------------------------------------------
end
