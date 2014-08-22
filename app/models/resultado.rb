class Resultado < ActiveRecord::Base
  # include DateModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :user

  # scopes --------------------------------------------------------------------------------------
  scope :exportar, -> {
    includes(:exame)
    .order('exames.nome ASC, data ASC')
  }

  scope :listar, ->(
      nome='',
      data_inicial='',
      data_final='',
      format=nil,
      page=nil,
      order='exames.nome ASC, data DESC'
  ) {
    select('resultados.exame_id, exames.nome AS nome, COUNT(*) AS total')
    .joins(:exame)
    .where('exames.nome LIKE ?', "%#{ nome }%")
    .where('resultados.data >= ?', data_inicial.blank? ? '1000-01-01' : self.format_date_usa(data_inicial)) #unless data_inicial.blank?
    .where('resultados.data <= ?', data_final.blank? ? '9999-12-31' : self.format_date_usa(data_final)) #unless data_inicial.blank?
    .group('resultados.exame_id, exames.nome')
    .order(order)
    .page(page) if format.nil?
  }

  # validações ------------------------------------------------------------------------------------
  validates :data, :exame_id, :exame_nome, presence: true
  validates :valor, numericality: { less_than_or_equal_to: 99999999.99 },
            unless: Proc.new { |a| a.valor.blank? }

  # methods ---------------------------------------------------------------------------------------
  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end

  private
  def self.format_date_usa(value)
    return value if value.is_a?(Time)

    value = value.split('/') rescue ''
    Date.new(value[2].to_i, value[1].to_i, value[0].to_i) rescue ''
  end
end
