class ExamResult < ApplicationRecord
  self.table_name = 'exams_results'

  belongs_to :exam
  belongs_to :result

  validates :exam_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exam_id, uniqueness: { scope: :result_id }
  validates :result_id, uniqueness: { scope: :exam_id }

  scope :graphics, ->(user) {
    select('exams_results.exam_id, exams.name, count(1) as total')
      .joins(:exam, :result)
      .where('results.user_id = ?', user.id)
      .group('exams_results.exam_id, exams.name')
      .order('exams.name')
  }

  scope :ordered, lambda {
    select(:id, :value)
      .includes(exam: :unit)
      .order(id: :desc)
  }
end
