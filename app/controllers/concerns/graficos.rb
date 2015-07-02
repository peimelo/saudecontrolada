module Graficos
  extend ActiveSupport::Concern

  private

    def grafico_linha(titulo_y, registros, valor_minimo, valor_maximo, sulfixo_tooltip)
      categorias = []
      maximo = []
      minimo = []
      valor = []

      registros.reverse.each do |registro|
        categorias << l(registro.data, format: :default)
        valor << registro.valor.to_f
        maximo << valor_maximo
        minimo << valor_minimo
      end

      chart = LazyHighCharts::HighChart.new('graph') do |f|
        f.xAxis(categories: categorias, labels: { step: (valor.size / 2) })

        f.yAxis(title: { text: titulo_y })

        f.tooltip(valueSuffix: (' ' + sulfixo_tooltip))

        f.series(name: I18n.t('resultados.limite_maximo'), data: maximo, color: '#ff9b99') if maximo.size > 0
        f.series(name: I18n.t('resultados.limite_minimo'), data: minimo, color: '#f7be34') if minimo.size > 0
        f.series(name: I18n.t('resultados.meu_valor'), data: valor, color: '#000000')

        f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')

        f.plotOptions(line: { lineWidth: 5, marker: { enabled: valor.size > 1 ? false : true } })
      end
    end
end
