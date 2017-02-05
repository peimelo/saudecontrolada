class AlimentationFood < ApplicationRecord
  self.table_name = 'alimentations_foods'

  belongs_to :alimentation
  belongs_to :food

  validates :alimentation_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 1000.00 }
  validates :alimentation_id, uniqueness: { scope: :food_id }
  validates :food_id, uniqueness: { scope: :alimentation_id }

  # scope :graphics, ->(user) {
  #   select('exams_foods.exam_id, exams.name, count(1) as total')
  #     .joins(:exam, :food)
  #     .where('foods.user_id = ?', user.id)
  #     .group('exams_foods.exam_id, exams.name')
  #     .order('exams.name')
  # }

  # scope :graphic_values, ->(user, exam_id) {
  #   select('foods.id as food_id, foods.date, foods.description, exams_foods.id, exams_foods.value')
  #     .joins(:food)
  #     .where('foods.user_id = ? AND exams_foods.exam_id = ?', user.id, exam_id)
  #     .order('foods.date')
  # }

  scope :ordered, lambda {
    select(:id, :value)
      .includes(:food)
      .order(id: :desc)
  }
end
