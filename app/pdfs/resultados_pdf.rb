class ResultadosPdf < Prawn::Document
  def initialize(registros, model, current_user)
    super(top_margin: 50)
    @registros = registros
    @model = model
    @current_user = current_user
    
    titulo
    tabela
  end
  
  def linhas
    move_down 20
    [[
      @model.human_attribute_name(:nome),
      @model.human_attribute_name(:data),
      @model.human_attribute_name(:valor),
      @model.human_attribute_name(:unidade),
    ]] +
    @registros.map do |registro|
      [
        registro.exame.nome,
        I18n.l(registro.data),
        ApplicationController.helpers.numero_formatado(registro.valor),
        registro.exame.unidade.nil? ? '' : registro.exame.unidade.nome
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
    text I18n.t('activerecord.models.resultado.other'), size: 20, style: :bold
    text "#{ @current_user.name } - #{I18n.l(Time.now) }", size: 15, style: :bold
  end
end 