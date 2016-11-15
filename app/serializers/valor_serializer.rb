class ValorSerializer < ActiveModel::Serializer
  attributes :id,
             :gender,
             :idade_inferior,
             :idade_superior,
             :valido,
             :valor_inferior,
             :valor_superior,
             :reference

  def reference
    if object.reference
      ReferenceSerializer.new(object.reference).attributes
    else
      false
    end
  end
end
