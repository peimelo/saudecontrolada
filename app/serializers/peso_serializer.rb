class PesoSerializer < ActiveModel::Serializer
  attributes :id, :altura, :data, :imc, :valor, :maximum, :minimum
end
