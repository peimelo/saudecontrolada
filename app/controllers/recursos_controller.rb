class RecursosController < ApplicationController
  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_recurso, only: [:edit, :update, :destroy]

  def index
    @recursos = Recurso.listar(params[:search], params[:format], params[:page])

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @recurso = Recurso.new
  end

  def edit
  end

  def create
    @recurso = Recurso.new(recurso_params)

    if @recurso.save
      redirect_to recursos_url, notice: t('mensagens.flash.create', crud: Recurso.model_name.human)
    else
      render :new
    end
  end

  def update
    if @recurso.update_attributes(recurso_params)
      redirect_to recursos_url, notice: t('mensagens.flash.update', crud: Recurso.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @recurso.destroy
      redirect_to recursos_url, notice: t('mensagens.flash.destroy', crud: Recurso.model_name.human)
    else
      redirect_to recursos_url, alert: @recurso.errors.messages[:base][0]
    end
  end

  private
    def set_recurso
      @recurso = Recurso.find(params[:id])
    end

    def recurso_params
      params.require(:recurso).permit(
        :acao_id,
        :controlador_id,
        :nome,
        :recurso_categoria_id,
        :visivel
        )
    end
end
