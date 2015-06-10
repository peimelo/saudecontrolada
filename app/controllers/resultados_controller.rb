class ResultadosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_resultado, only: [:edit, :update, :destroy]

  # breadcrumb ----------------------------------------------------------------
  before_action ->(texto=t('activerecord.models.resultado.other'), url=resultados_path) {
    add_crumb(texto, url) }, except: [:index, :destroy]

  before_action only: [:edit, :update] do
    add_crumb(@resultado.exame.nome, resultado_path(@resultado.exame_id))
    add_crumb(t('views.edit.titulo', model: Resultado.model_name.human), edit_resultado_path(@resultado))
  end

  before_action ->(texto=t('views.new.titulo', model: Resultado.model_name.human), url=new_resultado_path) {
    add_crumb(texto, url) }, only: [:new, :create]

  before_action ->(texto=Exame.find(params[:id]).nome) {
    add_crumb(texto, resultados_path(params[:id])) }, only: :show

  # CRUD ----------------------------------------------------------------------
  def index
    if params[:format].nil?
      if !params[:nome].nil? or !params[:data_inicial].blank? or !params[:data_final].blank?
        @resultados = current_user.resultado.listar(
            params[:nome],
            params[:data_inicial],
            params[:data_final],
            params[:format],
            params[:page],
            sort_column + ' ' + sort_direction
        )
      else
        @resultados = nil
      end
    else
      @resultados = current_user.resultado.exportar()
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadosPdf.new(@resultados, Resultado, current_user)
        send_data pdf.render, filename: (Resultado.model_name.human + '.pdf'), disposition: 'inline'
      end
      #TODO: impressao nao esta correta
      format.xls
    end
  end

  def show
    @exame = Exame.find(params[:id])

    @resultados = current_user.resultado.where('exame_id = ?', @exame.id).order(sort_column + ' ' + sort_direction).
      page(params[:page])

    @valor_medio = current_user.resultado.where('exame_id = ?', @exame.id).average(:valor)

    resultados = current_user.resultado.where('exame_id = ?', @exame.id).order('data DESC')

    categories = []
    maximo = []
    minimo = []
    valor = []
    valor_referencia = @exame.valor_referencia(current_user.idade, current_user.gender)
    valor_superior = valor_referencia.valor_superior unless valor_referencia.nil?
    valor_inferior = valor_referencia.valor_inferior unless valor_referencia.nil?
    
    resultados.reverse.each do |v|
      categories << l(v.data, format: :default)
      valor << v.valor.to_f
      maximo << valor_superior.to_f unless valor_superior.nil?
      minimo << valor_inferior.to_f unless valor_inferior.nil?
    end
    
    @chart_resultado = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories, labels: { step: (valor.size / 2) })

      f.yAxis(title: { text: I18n.t('resultados.meu_valor') })

      f.tooltip(valueSuffix: (' ' + @exame.unidade.nome rescue ''))

      f.series(name: I18n.t('resultados.limite_maximo'), data: maximo, color: '#ff9b99') if maximo.size > 0
      f.series(name: I18n.t('resultados.meu_valor'), data: valor, color: '#000000', marker: { enabled: true, radius: 5, fillColor: '#00cccc' })
      f.series(name: I18n.t('resultados.limite_minimo'), data: minimo, color: '#f7be34') if minimo.size > 0

      f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')

      f.plotOptions(line: { lineWidth: 5, marker: { enabled: valor.size > 1 ? false : true } })
    end
  end

  def new
    @resultado = Resultado.new(data: session[:data_ultimo_resultado], exame_nome: params[:exame_nome])
  end

  def edit
  end

  def create
    @resultado = current_user.resultado.build(resultado_params)

    respond_to do |format|
      if @resultado.save
        session[:data_ultimo_resultado] = @resultado.data
        format.html { redirect_to resultados_url, notice: t('mensagens.flash.paper_trail.create', undo_link: undo_link) }
        format.json { render action: 'show', status: :created, location: @resultado }
      else
        format.html { render action: 'new' }
        format.json { render json: @resultado.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @resultado.update(resultado_params)
        session[:data_ultimo_resultado] = @resultado.data
        format.html { redirect_to resultado_url(@resultado.exame_id),
                                  notice: t('mensagens.flash.update') }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @resultado.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resultado.destroy
    respond_to do |format|
      format.html { redirect_to resultado_url(@resultado.exame_id),
                                notice: t('mensagens.flash.destroy', crud: Resultado.model_name.human) }
      format.json { head :no_content }
    end
  end

  private
    def resultado_params
      params.require(:resultado).permit(:data, :exame_nome, :valor)
    end

    def set_resultado
      @resultado = current_user.resultado.find(params[:id])
    end

    def sort_column
      if action_name == 'index'
        'exames.nome'
      else
        Resultado.column_names.include?(params[:sort]) ? params[:sort] : 'data'
      end
    end

  def sort_direction
    # no index mostra agrupado por nome de exame, no show mostra por data do resultado
    if action_name == 'index'
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
    else
      %w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
    end
  end

  def undo_link
    view_context.link_to(view_context.icon('eye', t('links.visualizar')),
                         resultado_path(@resultado.exame_id))
  end
end