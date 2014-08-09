class Unidade < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  has_many :exame, dependent: :nullify

  # validações ------------------------------------------------------------------------------------
end
