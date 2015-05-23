class DashboardController < ApplicationController
  def index
    @chart = @chart = LazyHighCharts::HighChart.new('graph')
    @peso_medio = current_user.peso.average(:peso)
    @peso_atual = current_user.peso.page(params[:page]).order(data: :desc).first
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

    categories = []
    maximo = []
    minimo = []
    peso = []
    pesos.reverse.each do |p|
      categories << l(p.data, format: :default)
      peso << p.peso.to_f
      maximo << (24.99 * p.altura * p.altura).round(2).to_f
      minimo << (18.5 * p.altura * p.altura).round(2).to_f
    end

    @chart_peso = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories, labels: { step: (peso.size / 2) })

      f.yAxis(title: { text: 'Peso (kg)' })

      f.tooltip(valueSuffix: ' kg')

      f.series(name: 'Limite Máximo', data: maximo, color: '#ff9b99')
      f.series(name: 'Peso', data: peso, color: '#000000')
      f.series(name: 'Limite Mínimo', data: minimo, color: '#f7be34')

      f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')

      f.plotOptions(line: { lineWidth: 5, marker: { enabled: peso.size > 1 ? false : true } })
    end
  end
end
