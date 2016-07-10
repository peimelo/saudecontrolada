class ExamResult < ApplicationRecord
  self.table_name = 'exams_results'

  belongs_to :exam
  belongs_to :result

  validates :exam_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exam_id, uniqueness: { scope: :result_id }
  validates :result_id, uniqueness: { scope: :exam_id }
end
