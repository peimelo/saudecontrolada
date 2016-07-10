class ExamResult < ApplicationRecord
  belongs_to :exame
  belongs_to :result

  validates :exame_id, :value, presence: true
  validates :value, numericality: { less_than_or_equal_to: 99999999.99 }
  validates :exame_id, uniqueness: { scope: :result_id }
  validates :result_id, uniqueness: { scope: :exam_id }
end
