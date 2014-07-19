class Peso < ActiveRecord::Base
  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :user

  # validações ------------------------------------------------------------------------------------
  validates :altura, :data, :peso, presence: true
  validates :altura, numericality: { greater_than: 0, less_than_or_equal_to: 2.5 }
  validates :peso, numericality: { greater_than: 0, less_than_or_equal_to: 400 }

  # methods ---------------------------------------------------------------------------------------
  def altura=(value)
    write_attribute(:altura, value.to_s.gsub(',', '.').to_f)
  end

  def imc
    self.peso / (self.altura * self.altura)
  end

  def peso=(value)
    write_attribute(:peso, value.to_s.gsub(',', '.').to_f)
  end

  def peso_ideal
    "#{(18.5 * self.altura * self.altura).round(2).to_s.gsub('.', ',')} ~ \
    #{(24.99 * self.altura * self.altura).round(2).to_s.gsub('.', ',')}"
  end

  def situacao_imc
    case imc
      when 0..18.49
        'Abaixo do peso'
      when 18.5..24.99
        'Normal'
      when 25..29.99
        'Acima do peso'
      when 30..64
        'Obesidade'
    end
  end
end
