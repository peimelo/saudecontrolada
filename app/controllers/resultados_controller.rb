class ResultadosController < ApplicationController
  helper_method :sort_column, :sort_direction

  before_action :set_resultado, only: [:edit, :update, :destroy]

  def index
    if params[:format].nil?
      @resultados = current_user.resultado.select([:exame_id, :nome]).distinct.joins(:exame).order(sort_column + ' ' + sort_direction)
      
      
      
      #distinct(page(params[:page]).order(sort_column + ' ' + sort_direction)
    else
      @resultados = current_user.resultado.order(sort_column + ' ' + sort_direction)
    end

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ResultadosPdf.new(@resultados, Resultado)
        send_data pdf.render, filename: (Resultado.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xls
    end
  end

  def show
    @resultados = current_user.resultado.where('exame_id = ?', params[:id])
  end

  def new
    ultimo_resultado = current_user.resultado.select(:data).order('data DESC').first
    @resultado = Resultado.new(data: (ultimo_resultado.data rescue nil))
  end

  def edit
  end

  def create
    @resultado = current_user.resultado.build(resultado_params)

    respond_to do |format|
      if @resultado.save
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
        format.html { redirect_to resultados_url, notice: t('mensagens.flash.update', crud: Resultado.model_name.human) }
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
      format.html { redirect_to resultados_url, notice: t('mensagens.flash.destroy', crud: Resultado.model_name.human) }
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
      'exames.nome'
    end
end