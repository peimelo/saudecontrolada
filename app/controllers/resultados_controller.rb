class ResultadosController < ApplicationController
  before_action :set_exames, only: [:new, :edit, :create, :update]
  before_action :set_resultado, only: [:edit, :update, :destroy]

  include Graficos

  def index
    @resultados = current_user.resultado.listar(
      params[:data_inicial],
      params[:data_final],
      params[:descricao]
    )
    @resultados = @resultados.page(params[:page]) unless params[:format].present?
  end

  def new
    @resultado = current_user.resultado.new
  end

  def edit
  end

  def create
    @resultado = current_user.resultado.build(resultado_params)

    if @resultado.save
      redirect_to resultados_url, notice: t('mensagens.flash.create')
    else
      render action: :new
    end
  end

  def update
    if @resultado.update(resultado_params)
      # session[:data_ultimo_resultado] = @resultado.data
      redirect_to resultados_url, notice: t('mensagens.flash.update')
    else
      render action: :edit
    end
  end

  def destroy
    @resultado.destroy
    redirect_to resultados_url, notice: t('mensagens.flash.destroy', crud: Resultado.model_name.human)
  end

  private

    def resultado_params
      unless params[:resultado][:exame_resultado_attributes].nil?
        params[:resultado][:exame_resultado_attributes].each do |exame_resultado|
          unless exame_resultado[1][:valor].nil?
            exame_resultado[1][:valor] = exame_resultado[1][:valor].gsub(',', '.')
          end
        end
      end

      params.require(:resultado).permit(
        :data,
        :descricao,
        exame_resultado_attributes: [
          :id,
          :exame_id,
          :valor,
          :_destroy
        ])
    end

    def set_exames
      @exames = Exame.listar
    end

    def set_resultado
      @resultado = current_user.resultado.find(params[:id])
    end
end
