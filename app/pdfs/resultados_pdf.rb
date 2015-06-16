class ResultadosPdf < Prawn::Document
  def initialize(registros, model, current_user)
    super(top_margin: 50)
    @registros = registros
    @model = model
    @current_user = current_user
    
    titulo
    tabela_por_exame
  end
  
  def linhas
    valor_referencia = @exame.valor_referencia(@current_user.idade, @current_user.gender)

    [[
      @model.human_attribute_name(:data),
      @model.human_attribute_name(:valor),
      @model.human_attribute_name(:resultado),
    ]] +
    @resultados.map do |registro|
      [
        I18n.l(registro.data),
        ApplicationController.helpers.numero_formatado(registro.valor, (registro.exame.unidade.nome rescue '')),
        ApplicationController.helpers.situacao_resultado_exame(registro.valor, valor_referencia),
      ]
    end    
  end

  def tabela_por_exame
    @exame = nil
    @resultados = []

    @registros.each do |resultado|
      if @exame != resultado.exame
        tabela

        @exame = resultado.exame
        @resultados = []
        @resultados << resultado
      else
        @resultados << resultado
      end
    end

    tabela
  end
  
  def tabela
    return if @resultados.blank?

    text @exame.nome, size: 15, style: :bold
    text @exame.valor_referencia_extenso(@current_user.idade, @current_user.gender), size: 10, style: :bold

    table linhas do
      row(0).font_style = :bold
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.header = true
    end
    move_down 20
  end
  
  def titulo
    text I18n.t('activerecord.models.resultado.other'), size: 20, style: :bold
    text "#{ @current_user.name } - #{I18n.l(Time.now) }", size: 15, style: :bold
    move_down 20
  end
end
