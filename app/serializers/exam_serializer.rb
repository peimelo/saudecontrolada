class ExamSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit

  def unit
    if object.unit
      UnitSerializer.new(object.unit).attributes
    else
      false
    end
  end
end
