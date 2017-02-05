class FoodSerializer < ActiveModel::Serializer
  attributes :id, :name, :measure, :amount, :cho, :kcal
end
