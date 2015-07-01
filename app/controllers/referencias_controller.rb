class ReferenciasController < ApplicationController
  before_action :user_administrador_sistema?
  before_action :set_referencia, only: [:edit, :update, :destroy]

  def index
    @referencias = Referencia.listar(params[:search])
    @referencias = @referencias.page(params[:page]) unless params[:format].present?
  end

  def new
    @referencia = Referencia.new
  end

  def edit
  end

  def create
    @referencia = Referencia.new(referencia_params)

    if @referencia.save
      redirect_to referencias_url, notice: t('mensagens.flash.create')
    else
      render :new
    end
  end

  def update
    if @referencia.update(referencia_params)
      redirect_to referencias_url, notice: t('mensagens.flash.update')
    else
      render :edit
    end
  end

  def destroy
    if @referencia.destroy
      redirect_to referencias_url, notice: t('mensagens.flash.destroy')
    else
      redirect_to referencias_url, alert: @referencia.errors.messages[:base][0]
    end
  end

  private

    def referencia_params
      params.require(:referencia).permit(:nome)
    end

    def set_referencia
      @referencia = Referencia.find(params[:id])
    end
end
