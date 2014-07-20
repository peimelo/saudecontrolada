class AcoesController < ApplicationController
  skip_before_action :tem_permissao?
  before_action :user_administrador?
  before_action :set_acao, only: [:edit, :update, :destroy]

  def index
    @acoes = Acao.listar(params[:search], params[:page], params[:format])

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @acao = Acao.new
  end

  def edit
  end

  def create
    @acao = Acao.new(acao_params)

    if @acao.save
      redirect_to acoes_url, notice: t('mensagens.flash.create', crud: Acao.model_name.human)
    else
      render :new
    end
  end

  def update
    if @acao.update(acao_params)
      redirect_to acoes_url, notice: t('mensagens.flash.update', crud: Acao.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @acao.destroy
      redirect_to acoes_url, notice: t('mensagens.flash.destroy', crud: Acao.model_name.human)
    else
      redirect_to acoes_url, alert: @acao.errors.messages[:base][0]
    end
  end

  private
    def acao_params
      params.require(:acao).permit(:nome)
    end

    def set_acao
      @acao = Acao.find(params[:id])
    end
end