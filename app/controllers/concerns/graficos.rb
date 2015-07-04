module Graficos
  extend ActiveSupport::Concern

  private

    def grafico_gauge_imc(titulo, titulo_serie, valor)
      LazyHighCharts::HighChart.new('graph') do |f|
        f.chart(
          type: 'gauge',
          plotBackgroundColor: nil,
          plotBackgroundImage: nil,
          plotBorderWidth: 0,
          plotShadow: false
        )

        f.pane(
          startAngle: -150,
          endAngle: 150,
          background: [{
                         backgroundColor: {
                           linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                           stops: [[0, '#FFF'], [1, '#333']]
                         },
                         borderWidth: 0,
                         outerRadius: '109%'
                       }, {
                         backgroundColor: {
                           linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                           stops: [[0, '#333'], [1, '#FFF']]
                         },
                         borderWidth: 1,
                         outerRadius: '107%'
                       }, {
                       }, {
                         backgroundColor: '#DDD',
                         borderWidth: 0,
                         outerRadius: '105%',
                         innerRadius: '103%'
                       }]
        )

        f.yAxis(
          min: 0,
          max: 81,

          minorTickInterval: 'auto',
          minorTickWidth: 1,
          minorTickLength: 10,
          minorTickPosition: 'inside',
          minorTickColor: '#666',

          tickPixelInterval: 30,
          tickWidth: 2,
          tickPosition: 'inside',
          tickLength: 10,
          tickColor: '#666',
          labels: {
            step: 2,
            rotation: 'auto'
          },
          title: {
            text: titulo
          },
          plotBands: [
                 { from: 0, to: 18.49, color: '#f7be34' }, # abaixo
                 { from: 18.5, to: 24.99, color: '#a3c853' }, # normal
                 { from: 25, to: 29.99, color: '#ff9b99' }, # acima
                 { from: 30, to: 81, color: '#b02e25' }, # obeso 8a403b
               ]
        )

        f.series(
          name: titulo_serie,
          data: [valor]
        )
      end if valor <= 81
    end

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

      LazyHighCharts::HighChart.new('graph') do |f|
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
