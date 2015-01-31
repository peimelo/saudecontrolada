ActiveSupport::Inflector.inflections(:en) do |inflect|
  inflect.acronym 'API'

  inflect.irregular 'acao', 'acoes'
  inflect.irregular 'controlador', 'controladores'
  inflect.irregular 'erro_status', 'erros_status'
  inflect.irregular 'recurso_categoria', 'recursos_categorias'
  inflect.irregular 'referencia', 'referencias'
  inflect.irregular 'valor', 'valores'
end
