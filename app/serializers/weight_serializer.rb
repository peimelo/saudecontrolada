class WeightSerializer < ActiveModel::Serializer
  attributes :id, :height, :date, :imc, :value, :maximum, :minimum
end
