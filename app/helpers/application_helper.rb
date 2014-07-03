module ApplicationHelper
  def botao(label, options={})
    options = {
        class: 'btn btn-primary'#,
        # data: { disable_with: t('links.disable_with') }
    }.merge(options)

    button_tag label, options
  end

  def botao_cancelar(url, options={})
    options = {
        class: 'btn btn-default'
    }.merge(options)

    link_to t('links.cancelar'), url, options
  end

  def corrigir_erros(tem_erro)
    render partial: 'layouts/alert_model_error', locals: {tem_erro: tem_erro}
  end

  def titulo(title)
    content_tag(:h3, title)
  end
end
