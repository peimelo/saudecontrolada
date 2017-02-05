class AlimentationFoodSerializer < ActiveModel::Serializer
  attributes :id, :value
  belongs_to :food
end
