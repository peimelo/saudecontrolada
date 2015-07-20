class ExamesPdf < Prawn::Document
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
      @model.human_attribute_name(:nome)
    ]] +
    @registros.map do |registro|
      [
        registro.obter_hierarquia
      ]
    end    
  end
  
  def titulo
    text I18n.t('activerecord.models.exame.other'), size: 20, style: :bold
  end
end
