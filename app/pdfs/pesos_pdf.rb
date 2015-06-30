class PesosPdf < Prawn::Document
  def initialize(registros, model)
    super(top_margin: 50)
    @registros = registros
    @model = model
    
    titulo
    tabela_linhas()
  end
  
  def linhas
    move_down 20
    [[
      @model.human_attribute_name(:data),
      @model.human_attribute_name(:altura),
      @model.human_attribute_name(:valor),
      @model.human_attribute_name(:peso_ideal),
      @model.human_attribute_name(:situacao_imc)
    ]] +
    @registros.map do |registro|
      [
        I18n.l(registro.data),
        ApplicationController.helpers.number_to_human(registro.altura),
        ApplicationController.helpers.number_to_human(registro.valor, precision: 4),
        registro.peso_ideal,
        ApplicationController.helpers.situacao_imc(registro.imc, false)
      ]
    end    
  end
  
  def titulo
    text I18n.t('activerecord.models.peso.other'), size: 20, style: :bold
  end
end
