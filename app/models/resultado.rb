class Resultado < ActiveRecord::Base
  include SearchModule

  # relacionamentos -------------------------------------------------------------------------------
  belongs_to :exame
  belongs_to :user

  # scopes --------------------------------------------------------------------------------------
  scope :listar, ->(search=nil, format=nil, page=nil, order='nome') {
    select('exame_id, nome, COUNT(*) AS total')
    .joins(:exame)
    .group('exame_id, nome')
    # search(search)
    # .order(order)
    # .page(page) if format.nil?
  }
  # if params[:format].nil?
  #   @resultados = current_user.resultado.select([:exame_id, :nome]).distinct.joins(:exame).
  #       order(sort_column + ' ' + sort_direction)#.page(params[:page])
  # else
  #   @resultados = current_user.resultado.order(sort_column + ' ' + sort_direction)
  # end

  # @line_items = @project.line_items.all(
  #     :group  => "device_id",
  #     :select => "device_id, COUNT(*) as count"
  # )

  # validações ------------------------------------------------------------------------------------
  validates :data, :exame_id, :exame_nome, presence: true

  # methods ---------------------------------------------------------------------------------------
  def exame_nome
    exame.try(:nome)
  end

  def exame_nome=(nome)
    self.exame_id = Exame.find_by_nome(nome).id rescue nil
  end
end
