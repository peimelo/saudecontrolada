class Peso < ActiveRecord::Base
  belongs_to :user

  validates :altura, :data, :peso, presence: true
  validates :altura, numericality: { greater_than: 0.48, less_than_or_equal_to: 2.5 }
  validates :peso, numericality: { greater_than_or_equal_to: 3.35, less_than_or_equal_to: 400 }

  def imc
    (self.peso / (self.altura * self.altura)).round(2)
  end

  def peso_ideal
    [valor_ideal(18.49), valor_ideal(24.99)].join(' ~ ')
  end

  private

  def valor_ideal(valor)
    (valor * altura * altura).round(2).to_s.gsub('.', ',')
  end
end
