class Peso < ApplicationRecord
  belongs_to :user

  validates :altura, :data, :valor, :user_id, presence: true
  validates :altura, numericality: {
    greater_than: 0.48, less_than_or_equal_to: 2.5
  }
  validates :valor, numericality: {
    greater_than_or_equal_to: 3.35, less_than_or_equal_to: 400
  }

  scope :ordered, lambda {
    select(:id, :altura, :data, :valor)
      .order(data: :desc)
  }

  def imc
    (valor / (altura * altura)).round(2)
  end

  def maximum
    valor_ideal(24.99)
  end

  def minimum
    valor_ideal(18.49)
  end

  private

  def valor_ideal(valor)
    (valor * altura * altura).round(2)
  end
end
