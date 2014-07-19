module ApplicationHelper
  def botao(label, options={})
    options = {
        class: 'btn btn-primary'#,
        # data: { disable_with: t('links.disable_with') }
    }.merge(options)

    button_tag label, options
  end

  # id: é usado para os testes das features
  def botao_alterar(registro, path, model, options={})
    options = {
        class: 'btn btn-default',
        id: "#{ t('links.alterar') }_#{registro.id}",
        title: t('titles.alterar', model: model.model_name.human)
    }.merge(options)

    label = raw('<i class="fa fa-pencil fa-lg"></i> ')

    link_to label, path, options
  end

  def botao_cancelar(url, options={})
    options = {
        class: 'btn btn-default'
    }.merge(options)

    link_to t('links.cancelar'), url, options
  end

  def botao_excluir(registro, registro_nome, model, options={})
    options = {
        class: 'btn btn-danger',
        data: {
            confirm: t('crud.tabela.confirmar_excluir_registro', crud: model.model_name.human, registro: registro_nome)
        },
        method: :delete,
        title: t('titles.excluir', model: model.model_name.human)
    }.merge(options)

    label = raw('<i class="fa fa-trash-o fa-lg"></i> ')

    link_to label, registro, options
  end

  def botao_incluir(controller, model, options={})
    options = {
        class: 'btn btn-primary',
        # data: { disable_with: t('links.disable_with') },
        id: t('links.incluir'),
        method: :get,
        title: t('titles.incluir', model: model.model_name.human)
    }.merge(options)

    label = raw('<i class="fa fa-file-o fa-lg"></i> ') + t('links.incluir')

    link_to label, { controller: controller, action: :new }, options
  end

  def botao_link(label, path, options={})
    options = {
        class: 'btn btn-primary',
        method: :get,
    }.merge(options)

    link_to label, path, options
  end

  def botao_salvar(options={})
    options = {
        class: 'btn btn-primary',
        #data: { disable_with: t('links.disable_with') }
    }.merge(options)

    label = raw('<i class="glyphicon glyphicon-ok"></i> ') + t('links.salvar')

    button_tag label, options
  end

  def corrigir_erros(tem_erro)
    render partial: 'layouts/alert_model_error', locals: {tem_erro: tem_erro}
  end

  def sortable(model, column)
    title = model.human_attribute_name(column)
    icone = column == sort_column ? " <i class='fa fa-sort-#{sort_direction}'></i>" : ''
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'

    link_to raw(title + icone), sort: column, direction: direction
  end

  def titulo(title)
    content_tag(:h3, title)
  end
end
