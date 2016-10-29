class ExamResultSerializer < ActiveModel::Serializer
  attributes :id, :value
  belongs_to :exam
end
