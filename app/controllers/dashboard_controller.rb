class DashboardController < ApplicationController
  include Graficos

  def index
    @peso_medio = current_user.peso.average(:valor)
    @peso_atual = current_user.peso.order(data: :desc).first
    return if @peso_atual.nil?

    @meu_imc = @peso_atual.imc.to_f

    @chart_imc = LazyHighCharts::HighChart.new('graph') do |f|
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
            text: 'IMC'
        },
        plotBands: [
          { from: 0, to: 18.49, color: '#f7be34' }, # abaixo
          { from: 18.5, to: 24.99, color: '#a3c853' }, # normal
          { from: 25, to: 29.99, color: '#ff9b99' }, # acima
          { from: 30, to: 81, color: '#b02e25' }, # obeso 8a403b
        ]
    )

    f.series(
        name: 'Meu IMC',
        data: [@meu_imc]
	    )
    end if @meu_imc <= 81

    pesos = current_user.peso.order(data: :desc)

    @chart_peso = grafico_linha(
      t('activerecord.attributes.peso.valor'),
      pesos,
      (18.5 * pesos[0].altura * pesos[0].altura).round(2).to_f,
      (24.99 * pesos[0].altura * pesos[0].altura).round(2).to_f,
      'kg'
    )
  end
end
