module ButtonHelper
  def botao(label, options = {})
    options = {
      class: 'btn btn-primary'
    }.merge(options)

    button_tag label, options
  end

  # id: é usado para os testes das features
  def botao_alterar(registro, path, model, options = {})
    options = {
      class: 'btn btn-default',
      id: "#{ t('links.alterar') }_#{registro.id}",
      title: t('titles.alterar', model: model.model_name.human)
    }.merge(options)

    label = raw('<i class="fa fa-pencil fa-lg"></i> ')

    link_to label, path, options
  end

  def botao_cancelar(url, options = {})
    options = {
        class: 'btn btn-default'
    }.merge(options)

    link_to t('links.cancelar'), url, options
  end

  def botao_excluir(registro, model, options = {})
    registro_nome = options[:registro_nome]
    registro_nome ||= registro.nome if model.column_names.include?('nome')

    options = {
      class: 'btn btn-danger',
      data: {
          confirm: t('crud.tabela.confirmar_excluir_registro', crud: model.model_name.human, registro: registro_nome)
      },
      method: :delete,
      title: t('titles.excluir', model: model.model_name.human)
    }.merge(options)

    if options[:sem_confimar] == true
      options.delete(:data)
    end

    options[:texto_botao] ||= ''

    label = icon('trash-o fa-lg', options[:texto_botao])

    link_to label, registro, options
  end

  def botao_incluir(controller, model, options = {})
    options = {
      class: 'btn btn-success',
      id: t('links.incluir'),
      method: :get,
      title: t('titles.incluir', model: model.model_name.human)
    }.merge(options)

    label = raw('<i class="fa fa-file-o fa-lg"></i> ') + t('links.incluir')

    link_to label, { controller: controller, action: :new }, options
  end

  def botao_link(label, path, options = {})
    options = {
      class: 'btn btn-primary',
      method: :get
    }.merge(options)

    link_to label, path, options
  end

  def botao_salvar(options = {})
    options = {
        class: 'btn btn-primary'
    }.merge(options)

    label = icon('check fa-lg', t('links.salvar'))

    button_tag label, options
  end

  def botao_visualizar(path, model, options = {})
    options = {
        class: 'btn btn-default',
        title: t('titles.visualizar', model: model.model_name.human)
    }.merge(options)

    label = icon('eye fa-lg')

    link_to label, path, options
  end
end
