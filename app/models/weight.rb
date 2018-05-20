class Weight < ApplicationRecord
  belongs_to :user

  validates :date, uniqueness: { scope: :user_id }
  validates :height, :date, :value, :user_id, presence: true
  validates :height, numericality: {
    greater_than: 0.48, less_than_or_equal_to: 2.5
  }
  validates :value, numericality: {
    greater_than_or_equal_to: 3.35, less_than_or_equal_to: 400
  }

  scope :recent_height, lambda {
    select(:id, :height)
      .order(date: :desc)
  }

  scope :ordered, lambda {
    select(:id, :height, :date, :value)
      .order(date: :asc)
  }

  def imc
    (value / (height * height)).round(2)
  end

  def maximum
    ideal_value(24.99)
  end

  def minimum
    ideal_value(18.49)
  end

  private

  def ideal_value(value)
    (value * height * height).round(2)
  end
end
