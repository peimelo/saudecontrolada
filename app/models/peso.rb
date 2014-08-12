class Peso < ActiveRecord::Base
  # include DateModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :user

  # validações ------------------------------------------------------------------------------------
  validates :altura, :data, :peso, presence: true
  validates :altura, numericality: { greater_than: 0.48, less_than_or_equal_to: 2.5 }
  validates :peso, numericality: { greater_than_or_equal_to: 3.35, less_than_or_equal_to: 400 }

  # methods ---------------------------------------------------------------------------------------
  # def altura=(value)
    # write_attribute(:altura, value.to_s.gsub(',', '.').to_f)
  # end

  # def data=(value)
    # write_attribute(:data, format_date_usa(value))
  # end

  def imc
    (self.peso / (self.altura * self.altura)).round(2)
  end

  # def peso=(value)
    # write_attribute(:peso, value.to_s.gsub(',', '.').to_f)
  # end

  def peso_ideal
    "#{(18.49 * self.altura * self.altura).round(2).to_s.gsub('.', ',')} ~ #{(24.99 * self.altura * self.altura).round(2).to_s.gsub('.', ',')}"
  end
end
