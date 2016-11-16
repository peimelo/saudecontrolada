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
    references = object.valor_referencia(current_user.age, current_user.gender)
    if references
      ValorSerializer.new(references).attributes
    else
      false
    end
  end
end
