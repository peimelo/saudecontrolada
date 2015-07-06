class ResultadosController < ApplicationController
  include Graficos

  before_action :set_resultado, only: [:edit, :update, :destroy]

  def index
    @resultados = current_user.resultado.listar
    @resultados = @resultados.page(params[:page]) unless params[:format].present?

    # if params[:format].nil?
    #   if params[:nome].blank? and params[:data_inicial].blank? and params[:data_final].blank?
    #     @resultados = nil
    #   else
    #     @resultados = current_user.resultado.listar_por_total_exame(
    #       params[:nome],
    #       params[:data_inicial],
    #       params[:data_final]
    #     ).page(params[:page])
    #   end
    # else
    #   @resultados = current_user.resultado.exportar
    # end
    #
    # respond_to do |format|
    #   format.html
    #   format.pdf do
    #     pdf = ResultadosPdf.new(@resultados, Resultado, current_user)
    #     send_data pdf.render, filename: (Resultado.model_name.human + '.pdf'), disposition: 'inline'
    #   end
    # end
  end

  def show
    @exame = Exame.find(params[:id])

    @resultados = current_user.resultado.listar(@exame.id).page(params[:page])

    @valor_medio = current_user.resultado.media_valor_de_exame(@exame)

    valor_referencia = @exame.valor_referencia(current_user.idade, current_user.gender)

    @chart_resultado = grafico_linha(
      I18n.t('resultados.meu_valor'),
      @resultados,
      (valor_referencia.valor_inferior.to_f unless valor_referencia.nil?),
      (valor_referencia.valor_superior.to_f unless valor_referencia.nil?),
      (@exame.unidade.nome rescue '')
    )
  end

  def new
    @exame = Exame.find_by_nome(params[:exame_nome]) # breadcrumbs
    @resultado = current_user.resultado.new(data: session[:data_ultimo_resultado], exame_nome: params[:exame_nome])
  end

  def edit
  end

  def create
    @resultado = current_user.resultado.build(resultado_params)

    if @resultado.save
      session[:data_ultimo_resultado] = @resultado.data
      redirect_to resultados_url, notice: t('mensagens.flash.with_link.create', with_link: with_link)
    else
      render action: :new
    end
  end

  def update
    if @resultado.update(resultado_params)
      session[:data_ultimo_resultado] = @resultado.data
      redirect_to resultado_url(@resultado.exame), notice: t('mensagens.flash.with_link.update', with_link: with_link)
    else
      render action: :edit
    end
  end

  def destroy
    @resultado.destroy
    redirect_to resultado_url(@resultado.exame),
      notice: t('mensagens.flash.destroy', crud: Resultado.model_name.human)
  end

  private

    def resultado_params
      params[:resultado][:valor] = params[:resultado][:valor].gsub(',', '.') unless params[:resultado][:valor].nil?

      params.require(:resultado).permit(:data, :exame_nome, :valor)
    end

    def set_resultado
      @resultado = current_user.resultado.find(params[:id])
    end

    def with_link
      view_context.link_to(view_context.icon('eye', t('links.visualizar')), edit_resultado_path(@resultado))
    end
end
