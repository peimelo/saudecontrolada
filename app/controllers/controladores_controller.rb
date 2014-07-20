class ControladoresController < ApplicationController
  skip_before_action :tem_permissao?
  before_action :user_administrador?
  before_action :set_controlador, only: [:edit, :update, :destroy]

  def index
    @controladores = Controlador.listar(params[:search], params[:page], params[:format])

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @controlador = Controlador.new
  end

  def edit
  end

  def create
    @controlador = Controlador.new(controlador_params)

    if @controlador.save
      redirect_to controladores_url, notice: t('mensagens.flash.create', crud: Controlador.model_name.human)
    else
      render :new
    end
  end

  def update
    if @controlador.update(controlador_params)
      redirect_to controladores_url, notice: t('mensagens.flash.update', crud: Controlador.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @controlador.destroy
      redirect_to controladores_url, notice: t('mensagens.flash.destroy', crud: Controlador.model_name.human)
    else
      redirect_to controladores_url, alert: @controlador.errors.messages[:base][0]
    end
  end

  private
    def controlador_params
      params.require(:controlador).permit(:nome)
    end

    def set_controlador
      @controlador = Controlador.find(params[:id])
    end
end
