class ReferenciasController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_referencia, only: [:edit, :update, :destroy]

  def index
    @referencias = Referencia.listar(params[:search], params[:format], params[:page], sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @referencia = Referencia.new
  end

  def edit
  end

  def create
    @referencia = Referencia.new(referencia_params)

    if @referencia.save
      redirect_to referencias_url, notice: t('mensagens.flash.create', crud: Referencia.model_name.human)
    else
      render :new
    end
  end

  def update
    if @referencia.update(referencia_params)
      redirect_to referencias_url, notice: t('mensagens.flash.update', crud: Referencia.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @referencia.destroy
      redirect_to referencias_url, notice: t('mensagens.flash.destroy', crud: Referencia.model_name.human)
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

    def sort_column
      Referencia.column_names.include?(params[:sort]) ? params[:sort] : 'nome'
    end
end