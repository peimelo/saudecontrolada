class Resultado < ActiveRecord::Base
  # include DateModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :user

  # validações ------------------------------------------------------------------------------------
  validates :data, :exame_id, :exame_nome, presence: true

  # methods ---------------------------------------------------------------------------------------
  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end
end
