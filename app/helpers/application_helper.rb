module ApplicationHelper
  def corrigir_erros(tem_erro)
    render partial: 'layouts/alert_model_error', locals: { tem_erro: tem_erro }
  end

  def imagem_true(valor)
    icon('check fa-lg') if valor
  end

  def label_valor(label, valor)
    content_tag(:strong, label) + valor
  end

  def limpar_filtro(url, params)
    if !params[:search].blank? or !params[:nome].blank? or !params[:data_inicial].blank? or !params[:data_final].blank?
      link_to(icon('eraser', t('links.limpar_filtro')), url)
    end
  end

  def numero_formatado(numero, unidade = '')
    number_to_currency(numero, delimiter: '.', format: '%n%u', separator: ',', unit: unidade)
  end

  def situacao_resultado_exame(valor, valor_referencia)
    return '' if valor_referencia.nil?

    if valor_referencia.valor_inferior and valor_referencia.valor_superior
      if valor >= valor_referencia.valor_inferior and valor <= valor_referencia.valor_superior
        t('resultado_exame.ok')
      elsif valor > valor_referencia.valor_superior
        t('resultado_exame.acima')
      elsif valor < valor_referencia.valor_inferior
        t('resultado_exame.abaixo')
      end
    elsif valor_referencia.valor_inferior and valor_referencia.valor_superior.nil?
      if valor >= valor_referencia.valor_inferior
        t('resultado_exame.ok')
      elsif valor < valor_referencia.valor_inferior
        t('resultado_exame.abaixo')
      end
    elsif valor_referencia.valor_inferior.nil? and valor_referencia.valor_superior
      if valor <= valor_referencia.valor_superior
        t('resultado_exame.ok')
      elsif valor > valor_referencia.valor_superior
        t('resultado_exame.acima')
      end
    else
      ''
    end
  end

  def titulo(title)
    # usando em application.html.erb
    content_for :title do
      if title.scan('</i> ') == []
        title
      else
        title.split('</i> ')[1]
      end
    end

    content_tag(:h3, title)
  end
end
