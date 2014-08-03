class RecursosCategoriasController < ApplicationController
  helper_method :sort_column, :sort_direction

  skip_before_action :tem_permissao?
  before_action :user_administrador_sistema?
  before_action :set_recurso_categoria, only: [:edit, :update, :destroy]

  def index
    @recursos_categorias = RecursoCategoria.listar(params[:search], params[:format], params[:page],
                                                   sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.xls
    end
  end

  def new
    @recurso_categoria = RecursoCategoria.new
  end

  def edit
  end

  def create
    @recurso_categoria = RecursoCategoria.new(recurso_categoria_params)

    if @recurso_categoria.save
      redirect_to recursos_categorias_url, notice: t('mensagens.flash.create', crud: RecursoCategoria.model_name.human)
    else
      render :new
    end

  end

  def update
    if @recurso_categoria.update_attributes(recurso_categoria_params)
      redirect_to recursos_categorias_url, notice: t('mensagens.flash.update', crud: RecursoCategoria.model_name.human)
    else
      render :edit
    end
  
  end

  def destroy
    if @recurso_categoria.destroy
      redirect_to recursos_categorias_url, notice: t('mensagens.flash.destroy', crud: RecursoCategoria.model_name.human)
    else
      redirect_to recursos_categorias_url, alert: @recurso_categoria.errors.messages[:base][0]
    end

  end

  private
    def set_recurso_categoria
      @recurso_categoria = RecursoCategoria.find(params[:id])
    end

    def recurso_categoria_params
      params.require(:recurso_categoria).permit(:nome)
    end

  def sort_column
    RecursoCategoria.column_names.include?(params[:sort]) ? params[:sort] : 'nome'
  end
end
