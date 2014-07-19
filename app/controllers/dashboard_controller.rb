class DashboardController < ApplicationController
  def index
    @chart = @chart = LazyHighCharts::HighChart.new('graph')
    @peso_medio = Peso.average(:peso)
    peso_atual = current_user.peso.page(params[:page]).order('data DESC, created_at DESC').first
    return if peso_atual.nil?

    altura = []
    (1.5..2).step(0.05).each do |a|
      altura << a
    end

    imc = []
    peso = []
    (50..150).step(5).each do |p|
      imc << nil
      peso << p
    end

    i = 0
    (50..150).step(5).each do |p|
      if peso_atual.peso <= p
        imc[i] = peso_atual.altura.to_f
        break
      end
      i += 1
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: peso, title: { text: 'Peso (Kg)' })

      f.title(text: 'Índice de Massa Corporal (IMC)')
      f.tooltip(valueSuffix: ' m')
      f.yAxis(title: { text: 'Altura (m)' })

      f.plotOptions(area: { marker: { enabled: false, symbol: 'circle' } })

      #fdata: [  50,  55,  60,  65,  70,  75,  80,  85,  90,  95, 100, 105, 110, 115, 120, 125, 130, 135, 140])
      f.series( type: 'area', name: 'Abaixo do peso', color: '#cf9b98',
        data: [   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2]
      )
      f.series( type: 'area', name: 'Normal', color: '#a3c853',
        data: [ 1.6, 1.7, 1.8,1.85, 1.9,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2,   2]
      )
      f.series(type: 'area', name: 'Acima do peso', color: '#f7be34',
        data: [   0, 1.5, 1.5, 1.6,1.65, 1.7,1.75, 1.8,1.85, 1.9,   2,   2,   2,   2,   2,   2,   2,   2,   2]
      )
      f.series(type: 'area',name: 'Obesidade I', color: '#cf9b98',
        data: [   0,   0,   0, 1.5, 1.5,1.55, 1.6,1.65, 1.7,1.75, 1.8,1.85, 1.9,1.95,   2,   2,   2,   2,   2]
      )
      f.series(type: 'area', name: 'Obesidade II (Severa)', color: '#b02e25',
        data: [   0,   0,   0,   0,   0, 1.5, 1.5,1.55, 1.6, 1.6,1.65, 1.7,1.75, 1.8,1.85,1.85, 1.9,1.95,   2]
      )
      f.series(type: 'area', name: 'Obesidade III (Mórbida)', color: '#8a403b',
        data: [   0,   0,   0,   0,   0,   0,   0, 1.5, 1.5, 1.5,1.55, 1.6,1.75, 1.8,1.85,1.85, 1.9,1.95,   2]
      )
      f.series(type: 'scatter', name: 'Você', color: '#000000',
        data: imc,
        marker: { radius: 5 }
      )

      f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')
    end
  end
end
