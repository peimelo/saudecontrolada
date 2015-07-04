class DashboardController < ApplicationController
  include Graficos

  def index
    @peso_medio = current_user.peso.average(:valor)
    pesos = current_user.peso.listar
    @peso_atual = pesos[0]
    return if @peso_atual.nil?

    @meu_imc = @peso_atual.imc.to_f

    @chart_imc = grafico_gauge_imc('IMC', 'Meu IMC', @meu_imc)

    @chart_peso = grafico_linha(
      t('activerecord.attributes.peso.valor'),
      pesos,
      (18.5 * pesos[0].altura * pesos[0].altura).round(2).to_f,
      (24.99 * pesos[0].altura * pesos[0].altura).round(2).to_f,
      'kg'
    )
  end
end
