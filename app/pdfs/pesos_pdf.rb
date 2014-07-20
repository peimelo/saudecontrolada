class PesosPdf < Prawn::Document
  require 'prawn/table'

  def initialize(registros, model)
    super(top_margin: 50)
    @registros = registros
    @model = model
    
    titulo
    tabela
  end
  
  def linhas
    move_down 20
    [[
      @model.human_attribute_name(:data),
      @model.human_attribute_name(:altura),
      @model.human_attribute_name(:peso),
      @model.human_attribute_name(:peso_ideal),
      @model.human_attribute_name(:situacao_imc)
    ]] +
    @registros.map do |registro|
      [
        I18n.l(registro.data),
        ApplicationController.helpers.number_to_human(registro.altura),
        ApplicationController.helpers.number_to_human(registro.peso, precision: 4),
        registro.peso_ideal,
        ApplicationController.helpers.situacao_imc(registro.imc, false)
      ]
    end    
  end
  
  def tabela
    table linhas do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
  end
  
  def titulo
    text I18n.t('activerecord.models.peso.other'), size: 20, style: :bold
  end
end 