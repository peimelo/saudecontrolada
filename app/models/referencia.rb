class Referencia < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  has_many :valor, dependent: :nullify

  # validações ------------------------------------------------------------------------------------
end
