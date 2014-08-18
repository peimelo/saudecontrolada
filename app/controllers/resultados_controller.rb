class ResultadosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_resultado, only: [:edit, :update, :destroy]

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

  def index
    if params[:format].nil?
      @resultados = current_user.resultado.listar(params[:search], params[:format], params[:page],
                                                  sort_column + ' ' + sort_direction)
    else
      @resultados = current_user.resultado.exportar()
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadosPdf.new(@resultados, Resultado)
        send_data pdf.render, filename: (Resultado.model_name.human + '.pdf'), disposition: 'inline'
      end
      #TODO: impressao nao esta correta
      format.xls
    end
  end

  def show
    @resultados = current_user.resultado.where('exame_id = ?', params[:id]).order(sort_column + ' ' + sort_direction).
      page(params[:page])

    @exame = Exame.find(params[:id])
    @valor_medio = current_user.resultado.where('exame_id = ?', params[:id]).average(:valor)

    resultados = current_user.resultado.where('exame_id = ?', params[:id]).order('data DESC')

    categories = []
    maximo = []
    minimo = []
    valor = []
    valor_superior = @exame.valor_superior(current_user.idade)
    valor_inferior = @exame.valor_inferior(current_user.idade)
    
    resultados.reverse.each do |v|
      categories << l(v.data, format: :default)
      valor << v.valor.to_f
      maximo << valor_superior
      minimo << valor_inferior
    end
    
    @chart_resultado = LazyHighCharts::HighChart.new('graph') do |f|
      f.xAxis(categories: categories, labels: { step: (valor.size / 2) })

      f.yAxis(title: { text: ("Valor (#{ @exame.unidade.nome })" rescue 'Valor') })

      f.tooltip(valueSuffix: (@exame.unidade.nome rescue ''))

      f.series(name: 'Limite Máximo', data: maximo, color: '#ff9b99') if maximo.size > 0
      f.series(name: @exame.nome, data: valor, color: '#000000')
      f.series(name: 'Limite Mínimo', data: minimo, color: '#f7be34') if minimo.size > 0

      f.legend(align: 'center', borderWidth: 1, layout: 'horizontal')

      f.plotOptions(line: { lineWidth: 5, marker: { enabled: valor.size > 1 ? false : true } })
    end
  end

  def new
    @resultado = Resultado.new(data: session[:data_ultimo_resultado])
  end

  def edit
  end

  def create
    @resultado = current_user.resultado.build(resultado_params)

    respond_to do |format|
      if @resultado.save
        session[:data_ultimo_resultado] = @resultado.data
        format.html { redirect_to resultados_url, notice: t('mensagens.flash.create', crud: Resultado.model_name.human) }
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
        format.html { redirect_to resultado_url(@resultado.exame_id),
                                  notice: t('mensagens.flash.update', crud: Resultado.model_name.human) }
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
end