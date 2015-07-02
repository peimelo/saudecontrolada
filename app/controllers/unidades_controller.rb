class UnidadesController < ApplicationController
  before_action :user_administrador_sistema?
  before_action :set_unidade, only: [:edit, :update, :destroy]

  def index
    @unidades = Unidade.listar(params[:search])
    @unidades = @unidades.page(params[:page]) unless params[:format].present?
  end

  def new
    @unidade = Unidade.new
  end

  def edit
  end

  def create
    @unidade = Unidade.new(unidade_params)

    if @unidade.save
      redirect_to unidades_url, notice: t('mensagens.flash.create')
    else
      render :new
    end
  end

  def update
    if @unidade.update(unidade_params)
      redirect_to unidades_url, notice: t('mensagens.flash.update')
    else
      render :edit
    end
  end

  def destroy
    if @unidade.destroy
      redirect_to unidades_url, notice: t('mensagens.flash.destroy')
    else
      redirect_to unidades_url, alert: @unidade.errors.messages[:base][0]
    end
  end

  private

    def unidade_params
      params.require(:unidade).permit(:nome)
    end

    def set_unidade
      @unidade = Unidade.find(params[:id])
    end
end
