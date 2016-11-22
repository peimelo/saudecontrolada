class GraphicValuesSerializer < ActiveModel::Serializer
  attributes :id, :date, :description, :result_id, :value
end
