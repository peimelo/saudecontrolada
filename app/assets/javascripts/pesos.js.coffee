if $('#container').data('categories') != null
  Highcharts.setOptions
    lang:
      contextButtonTitle: "Opções de imprimir e exportar o gráfico"
      decimalPoint: ","
      printChart: "Imprimir o gráfico"
  new Highcharts.Chart
    chart:
      renderTo: "container"
      type: 'line'
    title:
      text: 'Peso'
      x: -20 # center
    subtitle:
      text: 'Evolução do Peso por Data'
      x: -20
    xAxis:
      categories: $('#container').data('categories')
    yAxis:
      min: 9,
      plotLines: [{
        value: 0,
        width: 1,
        color: '#808080'
      }]
      title:
        text: 'Peso (Kg)'
    tooltip:
      valueSuffix: 'Kg'
    legend:
      layout: 'horizontal',
      align: 'center',
      borderWidth: 0
    series: [{
      name: 'Limite Máximo',
      data: $('#container').data('maximo').map (s) -> (Number) s
    }, {
      name: 'Peso',
      data: $('#container').data('pesos').map (s) -> (Number) s
    }, {
      name: 'Limite Mínimo',
      data: $('#container').data('minimo').map (s) -> (Number) s
    }]
