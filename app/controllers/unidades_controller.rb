class UnidadesController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_unidade, only: [:edit, :update, :destroy]

  def index
    @unidades = Unidade.listar(params[:search], params[:format], params[:page], sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @unidade = Unidade.new
  end

  def edit
  end

  def create
    @unidade = Unidade.new(unidade_params)

    if @unidade.save
      redirect_to unidades_url, notice: t('mensagens.flash.paper_trail.create', undo_link: undo_link)
    else
      render :new
    end
  end

  def update
    if @unidade.update(unidade_params)
      redirect_to unidades_url, notice: t('mensagens.flash.paper_trail.update', undo_link: undo_link)
    else
      render :edit
    end
  end

  def destroy
    if @unidade.destroy
      redirect_to unidades_url, notice: t('mensagens.flash.paper_trail.destroy', undo_link: undo_link)
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

    def sort_column
      Unidade.column_names.include?(params[:sort]) ? params[:sort] : 'nome'
    end
    
    def undo_link
      view_context.link_to(view_context.icon('undo', t('links.desfazer')),
        revert_version_path(@unidade.versions.last), method: :post) rescue nil
    end
end
