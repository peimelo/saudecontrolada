class ExamesPdf < Prawn::Document
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
      @model.human_attribute_name(:nome)
    ]] +
    @registros.map do |registro|
      [
        registro.nome
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
    text I18n.t('activerecord.models.exame.other'), size: 20, style: :bold
  end
end 