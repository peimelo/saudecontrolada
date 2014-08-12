class ExamesController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_exame, only: [:edit, :update, :destroy]

  def index
    @exames = Exame.listar(params[:search], params[:format], params[:page], sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = ExamesPdf.new(@exames, Exame)
        send_data pdf.render, filename: (Exame.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xls
    end
  end

  def new
    @exame = Exame.new
    # @exame.build_valores_referencias
    # @exame.valores_referencias.build
    # @exame.valores_referencias << ValorReferencia.new
  end

  def edit
  end

  def create
    @exame = Exame.new(exame_params)

    if @exame.save
      redirect_to exames_url, notice: t('mensagens.flash.create', crud: Exame.model_name.human)
    else
      render :new
    end
  end

  def update
    if @exame.update(exame_params)
      redirect_to exames_url, notice: t('mensagens.flash.update', crud: Exame.model_name.human)
    else
      render :edit
    end
  end

  def destroy
    if @exame.destroy
      redirect_to exames_url, notice: t('mensagens.flash.destroy', crud: Exame.model_name.human)
    else
      redirect_to exames_url, alert: @exame.errors.messages[:base][0]
    end
  end

  private
    def exame_params
      params.require(:exame).permit(
        :nome,
        :unidade_id,
        valor_attributes: [
          :id,
          :idade_inferior,
          :idade_superior,
          :referencia_id,
          :sexo,
          :valor_inferior,
          :valor_superior,
          :_destroy
        ]
      )
    end

    def set_exame
      @exame = Exame.find(params[:id])
    end

    def sort_column
      Exame.column_names.include?(params[:sort]) ? params[:sort] : 'nome'
    end
end