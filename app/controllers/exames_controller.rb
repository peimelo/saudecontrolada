class ExamesController < ApplicationController
  before_action :user_administrador_sistema?
  before_action :set_exame, only: [:edit, :update, :destroy]

  def index
    if params[:term]
      @exames = Exame.where('nome LIKE ?', "%#{ params[:term] }%").order(:nome)
    else
      @exames = Exame.arrange_as_array({order: :nome})
      @exames = @exames.paginate(page: params[:page]) unless params[:format].present?
    end

    respond_to do |format|
      format.json do
        render json: @exames.map(&:nome)
      end
      format.html
      format.pdf do
        pdf = ExamesPdf.new(@exames, Exame)
        send_data pdf.render, filename: (Exame.model_name.human + '.pdf'), disposition: 'inline'
      end
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{ t('activerecord.models.exame.other') }.xlsx"
      }
    end
  end

  def new
    @exame = Exame.new
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
        :parent_id,
        :unidade_id,
        valor_attributes: [
          :id,
          :idade_inferior,
          :idade_superior,
          :referencia_id,
          :sexo,
          :valido,
          :valor_inferior,
          :valor_superior,
          :_destroy
        ]
      )
    end

    def set_exame
      @exame = Exame.find(params[:id])
    end
end
