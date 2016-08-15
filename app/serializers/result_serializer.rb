class ResultSerializer < ActiveModel::Serializer
  attributes :id, :date, :description

  has_many :exam_result
end
