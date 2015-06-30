class UsersPdf < Prawn::Document
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
  
  def titulo
    text I18n.t('activerecord.models.user.other'), size: 20, style: :bold
  end
end
