class ExamDetailSerializer < ActiveModel::Serializer
  attributes :id, :name, :unit, :valor_referencia
  belongs_to :valor

  def unit
    if object.unit
      UnitSerializer.new(object.unit).attributes
    else
      false
    end
  end

  def valor_referencia
    ValorSerializer.new(object.valor_referencia(current_user.age, current_user.gender)).attributes
  end
end
