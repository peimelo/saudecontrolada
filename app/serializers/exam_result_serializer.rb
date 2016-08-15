class ExamResultSerializer < ActiveModel::Serializer
  attributes :id, :value, :exam

  def exam
    ExamSerializer.new(object.exam).attributes
  end
end
