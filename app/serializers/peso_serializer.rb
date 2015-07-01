# == Schema Information
#
# Table name: pesos
#
#  id         :integer          not null, primary key
#  data       :date             not null
#  valor      :decimal(5, 2)    not null
#  altura     :decimal(3, 2)    not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class PesoSerializer < ActiveModel::Serializer
  attributes :id, :data, :peso, :altura
end
