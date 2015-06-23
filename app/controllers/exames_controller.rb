class ExamesController < ApplicationController
  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_exame, only: [:edit, :update, :destroy]

  # breadcrumb ------------------------------------------------------------------------------------
  before_action ->(texto=t('activerecord.models.exame.other'), url=exames_path) {
    add_crumb(texto, url) }, except: [:index, :destroy]

  before_action only: [:edit, :update] do
    add_crumb(t('views.edit.titulo', model: Exame.model_name.human), edit_exame_path(@exame))
  end

  before_action ->(texto=t('views.new.titulo', model: Exame.model_name.human), url=new_exame_path) {
    add_crumb(texto, url) }, only: [:new, :create]

  # CRUD ------------------------------------------------------------------------------------------
  def index
    @exames = Exame.arrange_as_array({order: :nome})
    @exames = @exames.paginate(page: params[:page]) unless params[:format].present?

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

  def autocomplete
    @exames = Exame.order(:nome).where("nome LIKE ?", "%#{params[:term]}%")
    render json: @exames.map(&:nome)
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
