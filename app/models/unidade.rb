class Unidade < ActiveRecord::Base
  include SearchModule
  
  # relacionamentos -------------------------------------------------------------------------------
  has_many :exame, dependent: :nullify

  # validações ------------------------------------------------------------------------------------
  validates :nome, presence: true, uniqueness: { case_sensitive: false }

  # methods ---------------------------------------------------------------------------------------
  def idade_inferior=(value)
    write_attribute(:idade_inferior, value.to_s.gsub(',', '.').to_f)
  end

  def idade_superior=(value)
    write_attribute(:idade_superior, value.to_s.gsub(',', '.').to_f)
  end

  def valor_inferior=(value)
    write_attribute(:valor_inferior, value.to_s.gsub(',', '.').to_f)
  end

  # def valor_inferior
    # ActionController::Base.helpers.number_to_human(self.valor_inferior, precision: 2)
  # end

  def valor_superior=(value)
    write_attribute(:valor_superior, value.to_s.gsub(',', '.').to_f)
  end
end
