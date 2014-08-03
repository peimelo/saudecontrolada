class UsersPdf < Prawn::Document
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
      @model.human_attribute_name(:current_sign_in_at),
      @model.human_attribute_name(:email),
      @model.human_attribute_name(:created_at),
      @model.human_attribute_name(:sign_in_count)
    ]] +
    @registros.map do |registro|
      [
        registro.current_sign_in_at.nil? ? '' : I18n.l(registro.current_sign_in_at, format: :data_hora),
        registro.email,
        I18n.l(registro.created_at, format: :data_hora),
        registro.sign_in_count
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
    text I18n.t('activerecord.models.user.other'), size: 20, style: :bold
  end
end 